/*
 * Copyright (C) 2009 Paul Bender.
 *
 * This file is part of lircudevd.
 *
 * lircudevd is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 2 of the License, or
 * (at your option) any later version.
 *
 * lircudevd is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with lircudevd.  If not, see <http://www.gnu.org/licenses/>.
 */
#include <stddef.h>
#include <errno.h>
#include <fcntl.h>
#include <malloc.h>
#include <stdbool.h>
#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <syslog.h>
#include <unistd.h>

#include <sys/time.h>

#include <linux/input.h>
#include <linux/limits.h>
#include <linux/types.h>
#include <linux/uinput.h>

#include <libudev.h>

#include "evkey_code_to_name.h"
#include "evkey_name_to_code.h"
#include "evkey_type.h"

#include "input.h"
#include "lircd.h"
#include "monitor.h"

#define DEVICE_NAME    "lircudevd"
#define DEVICE_BUSTYPE 0
#define DEVICE_VENDOR  0
#define DEVICE_PRODUCT 0
#define DEVICE_VERSION 0

#define LIRCUDEVD_KEYMAP_CAPSLOCK   0x04000000
#define LIRCUDEVD_KEYMAP_NUMLOCK    0x02000000
#define LIRCUDEVD_KEYMAP_SCROLLLOCK 0x01000000
#define LIRCUDEVD_KEYMAP_CTRL       0x00080000
#define LIRCUDEVD_KEYMAP_SHIFT      0x00040000
#define LIRCUDEVD_KEYMAP_ALT        0x00020000
#define LIRCUDEVD_KEYMAP_META       0x00010000
#define LIRCUDEVD_KEYMAP_KEY        0x0000ffff

#if EV_MAX >= 65534
# error cannot define LIRCUDEVD_EV_NULL because EV_MAX exceeds 65534
#endif
#define LIRCUDEVD_EV_NULL 65535

#if KEY_MAX >= 65534
# error cannot define LIRCUDEVD_KEYMAP_NULL because KEY_MAX exceeds 65534
#endif
#define LIRCUDEVD_KEYMAP_NULL 65535

/*
 * Macros for reading ioctl bit fields.
 */
#define BITFIELD_BITS_PER_LONG      (sizeof(long) * 8)
#define BITFIELD_LONGS_PER_ARRAY(x) ((((x) - 1) / BITFIELD_BITS_PER_LONG) + 1)
#define BITFIELD_TEST(bit, array)   ((array[((bit) / BITFIELD_BITS_PER_LONG)] >> ((bit) % BITFIELD_BITS_PER_LONG)) & 0x1)

/*
 * The 'input_device_event' structure is used by the 'current' and
 * 'previous_list' members of the 'input_device' structure. It is used to hold
 * information associated with the current event (when used by the
 * 'input_device' structure's 'current' member) and the previous key press
 * events (when used by the 'input_device' structure's 'previous_list' member).
 * The current event is needed so that it can be forwared to either the lircd
 * socket or the mouse/joystick event output device. The previous key press
 * events are needed so that current input key repeat and release events can be
 * mapped to the same output key event used by the corresponding key press
 * event.
 */
struct input_device_event
{
    struct input_event event_in;        /* The input event. */
    struct input_event event_out;       /* The output event corresponding to the input event. */
    int repeat_count;                   /* The number of times the output key event has been repeated. */
    struct input_device_event *next;    /* Pointer to the next input device event. */
};

/*
 * The 'input_device_keymap' structure is used by the 'keymap' member of the
 * 'input_device' structure. It is used to hold information associated with
 * each mapping of an input keyboard shortcut key sequence code (zero or more
 * lock or modifier keys) followed by a base (non-lock and non-modifier) key
 * converted to a code) to an output key code.
 */
struct input_device_keymap
{
    __u32 code_in;                      /* The key map's input shortcut key sequence code. */
    __u16 code_out;                     /* The key map's output code. */
};

/*
 * The 'input_device' structure is used by the 'device_list' member of the
 * 'lircudevd_input' variable. It is used to hold information associated with
 * each input device handled by lircudevd. In addition to holding the keymap,
 * current event and previous key press events information for the input device,
 * it holds the information associated with the input device's mouse/joystick
 * event output device.
 */
struct input_device
{
    int fd;                             /* The input device's file descriptor. */
    char *path;                         /* The input device's path in the device file system. */
    struct input_device_keymap *keymap; /* The input device's key map table. */
    int keymap_size;                    /* The input device's key map table size. */
    __u32 lock_state;                   /* The input device's current lock key state. */
    __u32 modifier_state;               /* The input device's current modifier key state. */
    struct input_device_event current;  /* The input device's current event. */
    struct input_device_event *previous_list;        /* The input device's previous key events. */
    struct
    {
        bool capslock;
        bool numlock;
        bool scrolllock;
    } led;
    struct                              /* The input device's mouse/joystick event output device. */
    {
        int fd;                         /* The output device's file descriptor. */
        struct uinput_user_dev dev;     /* The output device. */
        bool syn_report;                /* The output device has a pending synchronization report event. */
    } output;
    struct input_device *next;          /* Pointer to the next input device in the linked list. */
};

/*
 * The 'lirudevd_input' variable holds information associated with input event
 * devices handled by lircudevd. It contains the information with associated
 * with monitoring udev for input event devices and a list of the input devices
 * currently being handled by lircudevd. The udev monitor file descriptor and
 * each of the the input device file descriptors are registered with monitor
 * so that input is notified of any udev and input device events that lircudevd
 * might need to handle.
 */
struct
{
    char *keymap_dir;                   /* The name of the directory containing key map files. */
    struct
    {
        int fd;
        struct udev_monitor *monitor;
    } udev;
    struct input_device *device_list;   /* The linked list of udev detected input devices. */
} lircudevd_input =
{
    .keymap_dir = NULL,
    .udev.fd = -1,
    .udev.monitor = NULL,
    .device_list = NULL
};

static struct input_device_event *input_device_previous_get(struct input_device *device)
{
    struct input_device_event *previous;

    if (device == NULL)
    {
        errno = EINVAL;
        return NULL;
    }
    for (previous = device->previous_list
        ; (previous != NULL) &&
          ((previous->event_in.type != device->current.event_in.type) ||
           (previous->event_in.code != device->current.event_in.code))
        ; previous = previous->next);

    return previous;
}

static int input_device_previous_pop(struct input_device *device)
{
    struct input_device_event **previous_ptr;
    struct input_device_event *previous;

    if (device == NULL)
    {
        errno = EINVAL;
        return -1;
    }

    previous_ptr = &(device->previous_list);
    while (*previous_ptr != NULL)
    {
        previous = *previous_ptr;
        if ((previous->event_in.type == device->current.event_in.type) &&
            (previous->event_in.code == device->current.event_in.code))
        {
            *previous_ptr = previous->next;
            free(previous);
        }
        else
        {
            previous_ptr = &((*previous_ptr)->next);
        }
    }

    return 0;
}

static int input_device_previous_push(struct input_device *device)
{
    struct input_device_event *previous;

    if (device == NULL)
    {
        errno = EINVAL;
        return -1;
    }

    /*
     * Pop any events with the same type,code pair off the list. This would only
     * occur were a previous key release event associated with this key lost.
     * However, without this, the loss of key release events would cause the
     * growth in the number of elements in 'previous_list' to be unbounded.
     */
    input_device_previous_pop(device);

    if ((previous = malloc(sizeof(struct input_device_event))) == NULL)
    {
        syslog(LOG_ERR, "failed to allocate memory for previous input device event: %s\n", strerror(errno));
        return -1;
    }

    *previous = device->current;

    previous->next = device->previous_list;
    device->previous_list = previous;

    return 0;
}

static int input_device_send(struct input_device *device, const struct input_event *event)
{
    if (device == NULL)
    {
        errno = EINVAL;
        return -1;
    }
    if (event == NULL)
    {
        errno = EINVAL;
        return -1;
    }

    if  ((event->type == EV_SYN) && (event->code == SYN_REPORT) && (event->value == 0))
    {
        if (device->output.syn_report == true)
        {
            if (write(device->output.fd, event, sizeof(*event)) != sizeof(*event))
            {
                syslog(LOG_ERR, "failed to flush event for %s: %s\n", device->output.dev.name, strerror(errno));
                return -1;
            }
            device->output.syn_report = false;
        }
    }
    else
    {
        if (write(device->output.fd, event, sizeof(*event)) != sizeof(*event))
        {
            syslog(LOG_ERR, "failed to send event (%d %d %d) for %s: %s\n", event->type, event->code, event->value, device->output.dev.name, strerror(errno));
            return -1;
        }
        device->output.syn_report = true;
    }

    return 0;
}

static int input_device_keymap_compare(const void *keymap_a, const void *keymap_b)
{
    __s32 code_a = (__s32)(((struct input_device_keymap *)keymap_a)->code_in);
    __s32 code_b = (__s32)(((struct input_device_keymap *)keymap_b)->code_in);

    return (code_a - code_b);
}

static int input_device_keymap_exit(struct input_device *device)
{
    if (device == NULL)
    {
        errno = EINVAL;
        return -1;
    }

    device->keymap_size = 0;

    if (device->keymap == NULL)
    {
        return 0;
    }

    free(device->keymap);
    device->keymap = NULL;

    return 0;
}

static int input_device_keymap_init(struct input_device *device, const char *keymap_dir, const char *keymap_file)
{
    char keymap_path[PATH_MAX + 1];
    FILE *fp;
    char *line;
    int line_len;
    int line_number;
    int keymap_index;

    if (device == NULL)
    {
        errno = EINVAL;
        return -1;
    }

    device->keymap = NULL;
    device->keymap_size = 0;

    if (keymap_dir == NULL)
    {
        errno = EINVAL;
        return -1;
    }

    if (keymap_file == NULL)
    {
        return 0;
    }

    if (strnlen(keymap_dir, PATH_MAX + 1) == PATH_MAX + 1)
    {
        errno = ENAMETOOLONG;
        syslog(LOG_ERR, "key map file directory '%s': %s\n", keymap_path, strerror(errno));
        return -1;
    }
    if (strnlen(keymap_file, PATH_MAX + 1) == PATH_MAX + 1)
    {
        errno = ENAMETOOLONG;
        syslog(LOG_ERR, "key map file name '%s': %s\n", keymap_file, strerror(errno));
        return -1;
    }

    if (strchr(keymap_file, '/'))
    {
        syslog(LOG_ERR, "key map file name '%s' contains a directory\n", keymap_file);
        return -1;
    }

    if (keymap_dir[strlen(keymap_dir) - 1] == '/')
    {
        if (snprintf(keymap_path, PATH_MAX + 1, "%s%s", keymap_dir, keymap_file) > PATH_MAX)
        {
            errno = ENAMETOOLONG;
            syslog(LOG_ERR, "key map file path name '%s%s': %s\n", keymap_dir, keymap_file, strerror(errno));
            return -1;
        }
    }
    else
    {
        if (snprintf(keymap_path, PATH_MAX + 1, "%s/%s", keymap_dir, keymap_file) > PATH_MAX)
        {
            errno = ENAMETOOLONG;
            syslog(LOG_ERR, "key map file path name '%s/%s': %s\n", keymap_dir, keymap_file, strerror(errno));
            return -1;
        }
    }

    if ((fp = fopen(keymap_path, "r")) == NULL)
    {
        syslog(LOG_ERR, "failed to open key map file '%s': %s\n", keymap_path, strerror(errno));
        return -1;
    }

    line_len = 0;

    keymap_index = 0;
    for (keymap_index = 0 ; getline(&line, &line_len, fp) >= 0 ; keymap_index++);
    device->keymap_size = keymap_index;
    if (device->keymap_size == 0)
    {
        return 0;
    }
    /*
     * Allocate memory for the key map table.
     */
    if ((device->keymap = malloc(device->keymap_size * sizeof(struct input_device_keymap))) == NULL)
    {
        syslog(LOG_ERR, "failed to allocate memory for the input device map %s: %s\n", keymap_path, strerror(errno));
        device->keymap_size = 0;
        return -1;
    }

    rewind(fp);

    line_number = 0;
    keymap_index = 0;
    while ((keymap_index < device->keymap_size) && (getline(&line, &line_len, fp) >= 0))
    {
        char *comment;
        char name_in[128];
        char name_out[128];
        char *name_in_part;
        char *name_in_part_state;
        bool keymap_valid;
        int i;

        device->keymap[keymap_index].code_in  = 0;
        device->keymap[keymap_index].code_out = 0;

        line_number++;

        /*
         * End the line at the first comment character
         */
        comment = strchr(line, '#');
        if (comment != NULL)
        {
            *comment = '\0';
        }
        /*
         * Skip blank (whitespace only) lines.
         */
        if (sscanf(line, " %127s", name_in) != 1)
        {
            continue;
        }
        /*
         * Split key map line into input keyboard shortcut and output key name.
         */
        if (sscanf(line, " %127[a-zA-Z0-9_+] = %127[a-zA-Z0-9_] ", name_in, name_out) != 2)
        {
            syslog(LOG_WARNING, "%s:%d: format is not <name-in> = <name-out>\n", keymap_path, line_number);
            continue;
        }
        name_in[127]  = '\0';
        name_out[127] = '\0';
        if (strlen(name_in) < 1)
        {
            syslog(LOG_WARNING, "%s:%d:<name-in>: name is empty", keymap_path, line_number);
            continue;
        }
        if (strlen(name_out) < 1)
        {
            syslog(LOG_WARNING, "%s:%d:<name-out>: name is empty", keymap_path, line_number);
            continue;
        }
        /*
         * parse input keyboard shortcut, validate lock key tockens, modifer
         * key tokens and base key name, and determine corresponding input code.
         * While the the tokens and names need not be treated as case sesitive,
         * they are treated as case sesitive in order to force a more consistant
         * file format.
         */
        name_in_part = strtok_r(name_in, "+", &name_in_part_state);
        if (name_in_part == NULL)
        {
            syslog(LOG_WARNING, "%s:%d:<name-in>: keyboard shortcut could not be parsed\n", keymap_path, line_number);
            continue;
        }
        keymap_valid = true;
        while (name_in_part)
        {
            if      (strcmp(name_in_part, "capslock") == 0)
            {
                if (device->keymap[keymap_index].code_in & LIRCUDEVD_KEYMAP_KEY)
                {
                    syslog(LOG_WARNING, "%s:%d:<name-in>: the '%s' lock key token appeared after the base key name\n",
                           keymap_path, line_number, name_in_part);
                    keymap_valid = false;
                    break;
                }
                if (device->keymap[keymap_index].code_in & LIRCUDEVD_KEYMAP_CAPSLOCK)
                {
                    syslog(LOG_WARNING, "%s:%d:<name-in>: the '%s' lock key token appeared more than once\n",
                           keymap_path, line_number, name_in_part);
                    keymap_valid = false;
                    break;
                }
                device->keymap[keymap_index].code_in |= LIRCUDEVD_KEYMAP_CAPSLOCK;
            }
            else if (strcmp(name_in_part, "numlock") == 0)
            {
                if (device->keymap[keymap_index].code_in & LIRCUDEVD_KEYMAP_KEY)
                {
                    syslog(LOG_WARNING, "%s:%d:<name-in>: the '%s' lock key token appeared after the base key name\n",
                           keymap_path, line_number, name_in_part);
                    keymap_valid = false;
                    break;
                }
                if (device->keymap[keymap_index].code_in & LIRCUDEVD_KEYMAP_NUMLOCK)
                {
                    syslog(LOG_WARNING, "%s:%d:<name-in>: the '%s' lock key token appeared more than once\n",
                           keymap_path, line_number, name_in_part);
                    keymap_valid = false;
                    break;
                }
                device->keymap[keymap_index].code_in |= LIRCUDEVD_KEYMAP_NUMLOCK;
            }
            else if (strcmp(name_in_part, "scrolllock") == 0)
            {
                if (device->keymap[keymap_index].code_in & LIRCUDEVD_KEYMAP_KEY)
                {
                    syslog(LOG_WARNING, "%s:%d:<name-in>: the '%s' lock key token appeared after the base key name\n",
                           keymap_path, line_number, name_in_part);
                    keymap_valid = false;
                    break;
                }
                if (device->keymap[keymap_index].code_in & LIRCUDEVD_KEYMAP_SCROLLLOCK)
                {
                    syslog(LOG_WARNING, "%s:%d:<name-in>: the '%s' lock key token appeared more than once\n",
                           keymap_path, line_number, name_in_part);
                    keymap_valid = false;
                    break;
                }
                device->keymap[keymap_index].code_in |= LIRCUDEVD_KEYMAP_SCROLLLOCK;
            }
            else if (strcmp(name_in_part, "ctrl") == 0)
            {
                if (device->keymap[keymap_index].code_in & LIRCUDEVD_KEYMAP_KEY)
                {
                    syslog(LOG_WARNING, "%s:%d:<name-in>: the '%s' modifier key token appeared after the base key name\n",
                           keymap_path, line_number, name_in_part);
                    keymap_valid = false;
                    break;
                }
                if (device->keymap[keymap_index].code_in & LIRCUDEVD_KEYMAP_CTRL)
                {
                    syslog(LOG_WARNING, "%s:%d:<name-in>: the '%s' modifier key token appeared more than once\n",
                           keymap_path, line_number, name_in_part);
                    keymap_valid = false;
                    break;
                }
                device->keymap[keymap_index].code_in |= LIRCUDEVD_KEYMAP_CTRL;
            }
            else if (strcmp(name_in_part, "shift") == 0)
            {
                if (device->keymap[keymap_index].code_in & LIRCUDEVD_KEYMAP_KEY)
                {
                    syslog(LOG_WARNING, "%s:%d:<name-in>: the '%s' modifier key token appeared after the base key name\n",
                           keymap_path, line_number, name_in_part);
                    keymap_valid = false;
                    break;
                }
                if (device->keymap[keymap_index].code_in & LIRCUDEVD_KEYMAP_SHIFT)
                {
                    syslog(LOG_WARNING, "%s:%d:<name-in>: the '%s' modifier key token appeared more than once\n",
                           keymap_path, line_number, name_in_part);
                    keymap_valid = false;
                    break;
                }
                device->keymap[keymap_index].code_in |= LIRCUDEVD_KEYMAP_SHIFT;
            }
            else if (strcmp(name_in_part, "alt") == 0)
            {
                if (device->keymap[keymap_index].code_in & LIRCUDEVD_KEYMAP_KEY)
                {
                    syslog(LOG_WARNING, "%s:%d:<name-in>: the '%s' modifier key token appeared after the base key name\n",
                           keymap_path, line_number, name_in_part);
                    keymap_valid = false;
                    break;
                }
                if (device->keymap[keymap_index].code_in & LIRCUDEVD_KEYMAP_ALT)
                {
                    syslog(LOG_WARNING, "%s:%d:<name-in>: the '%s' modifier key token appeared more than once\n",
                           keymap_path, line_number, name_in_part);
                    keymap_valid = false;
                    break;
                }
                device->keymap[keymap_index].code_in |= LIRCUDEVD_KEYMAP_ALT;
            }
            else if (strcmp(name_in_part, "meta") == 0)
            {
                if (device->keymap[keymap_index].code_in & LIRCUDEVD_KEYMAP_KEY)
                {
                    syslog(LOG_WARNING, "%s:%d:<name-in>: the '%s' modifier key token appeared after the base key name\n",
                           keymap_path, line_number, name_in_part);
                    keymap_valid = false;
                    break;
                }
                if (device->keymap[keymap_index].code_in & LIRCUDEVD_KEYMAP_META)
                {
                    syslog(LOG_WARNING, "%s:%d:<name-in>: the '%s' modifier key token appeared more than once\n",
                           keymap_path, line_number, name_in_part);
                    keymap_valid = false;
                    break;
                }
                device->keymap[keymap_index].code_in |= LIRCUDEVD_KEYMAP_META;
            }
            else
            {
                if (device->keymap[keymap_index].code_in & LIRCUDEVD_KEYMAP_KEY)
                {
                    keymap_valid = false;
                    break;
                }
                for (i = 0 ; (evkey_name_to_code[i].name != NULL) && (strcmp(name_in_part, evkey_name_to_code[i].name) != 0) ; i++);
                if (evkey_name_to_code[i].name == NULL)
                {
                    syslog(LOG_WARNING, "%s:%d:<name-in>: '%s' is not a known key name\n",
                           keymap_path, line_number, name_in_part);
                    keymap_valid = false;
                    break;
                }
                if ((strcmp(name_in_part, "KEY_CAPSLOCK"  ) == 0) ||
                    (strcmp(name_in_part, "KEY_NUMLOCK"   ) == 0) ||
                    (strcmp(name_in_part, "KEY_SCROLLLOCK") == 0))
                {
                    syslog(LOG_WARNING, "%s:%d:<name-in>: '%s' is a key name that is part of the lock key token.\n",
                           keymap_path, line_number, name_in_part);
                    keymap_valid = false;
                    break;
                }
                if ((strcmp(name_in_part, "KEY_LEFTCTRL"  ) == 0) || (strcmp(name_in_part, "KEY_RIGHTCTRL"  ) == 0) ||
                    (strcmp(name_in_part, "KEY_LEFTSHIFT" ) == 0) || (strcmp(name_in_part, "KEY_RIGHTSHIFT" ) == 0) ||
                    (strcmp(name_in_part, "KEY_LEFTALT"   ) == 0) || (strcmp(name_in_part, "KEY_RIGHTALT"   ) == 0) ||
                    (strcmp(name_in_part, "KEY_LEFTMETA"  ) == 0) || (strcmp(name_in_part, "KEY_RIGHTMETA"  ) == 0))
                {
                    syslog(LOG_WARNING, "%s:%d:<name-in>: '%s' is a key name that is part of the modifier key token.\n",
                           keymap_path, line_number, name_in_part);
                    keymap_valid = false;
                    break;
                }
                device->keymap[keymap_index].code_in |= (__u32)(evkey_name_to_code[i].code);
            }
            name_in_part = strtok_r(NULL, "+", &name_in_part_state);
        }
        if (keymap_valid == false)
        {
            continue;
        }
        if ((device->keymap[keymap_index].code_in & LIRCUDEVD_KEYMAP_KEY) == 0)
        {
            syslog(LOG_WARNING, "%s:%d:<name-in>: duplicate keyboard shortcut.\n",
            keymap_path, line_number);
            keymap_valid = false;
            continue;
        }
        for (i = 0 ; i < keymap_index ; i++)
        {
            if (device->keymap[keymap_index].code_in == device->keymap[i].code_in)
            {
                syslog(LOG_WARNING, "%s:%d:<name-in>: no key in keyboard shortcut.\n",
                keymap_path, line_number, name_in_part);
                keymap_valid = false;
                break;
            }
        }
        if (keymap_valid == false)
        {
            continue;
        }
        if (strcmp(name_out, "NULL") == 0)
        {
            device->keymap[keymap_index].code_out |= LIRCUDEVD_KEYMAP_NULL;
        }
        else
        {
            for (i = 0 ; (evkey_name_to_code[i].name != NULL) && (strcmp(name_out, evkey_name_to_code[i].name) != 0) ; i++);
            if (evkey_name_to_code[i].name == NULL)
            {
                syslog(LOG_WARNING, "%s:%d:<name-out>: '%s' is not a valid key name\n",
                       keymap_path, line_number, name_out);
                keymap_valid = false;
                break;
            }
            device->keymap[keymap_index].code_out |= evkey_name_to_code[i].code;
        }
        if (keymap_valid == false)
        {
            continue;
        }
        keymap_index++;
    }
    device->keymap_size = keymap_index;

    syslog(LOG_DEBUG, "%s: using %d valid keyboard shortcut mappings\n", keymap_path, device->keymap_size);

    /*
     * Sort the key map so that later look-ups can be done with a binary search.
     */
    qsort(device->keymap, device->keymap_size, sizeof(struct input_device_keymap), input_device_keymap_compare);

    free(line);
    fclose(fp);

    return 0;
}

static int input_device_keymap_run(struct input_device *device)
{
    int i;
    int j;
    struct input_device_keymap search;
    struct input_device_keymap *result;

    if (device == NULL)
    {
        errno = EINVAL;
        return -1;
    }

    device->current.event_out = device->current.event_in;

    if (device->keymap == NULL)
    {
        if (evkey_type[device->current.event_out.code] == LIRCUDEVD_EVKEY_TYPE_NULL)
        {
            device->current.event_out.code = (__u16)(LIRCUDEVD_KEYMAP_NULL);
        }
        return 0;
    }

    search.code_in  = device->lock_state | device->modifier_state | (__u32)(device->current.event_out.code);
    result = bsearch(&search, device->keymap, device->keymap_size, sizeof(struct input_device_keymap), input_device_keymap_compare);
    if (result == NULL)
    {
        if (evkey_type[device->current.event_out.code] == LIRCUDEVD_EVKEY_TYPE_NULL)
        {
            device->current.event_out.type = (__u16)(LIRCUDEVD_KEYMAP_NULL);
        }
        return 0;
    }
    device->current.event_out.code = result->code_out;

    return 0;
}

static int input_device_event_update(struct input_device *device, const struct input_event *event)
{
    struct input_device_event *previous;
    long time_delta;
    int i;

    if (device == NULL)
    {
        errno = EINVAL;
        return -1;
    }

    if (event == NULL)
    {
        errno = EINVAL;
        return -1;
    }

    device->current.event_in     = *event;
    device->current.event_out    = device->current.event_in;
    device->current.repeat_count = 0;
    device->current.next         = NULL;

    /*
     * When the device let's us know that the device's capslock, numlock or
     * scrolllock state has changed, make sure that our state matches the
     * device's state.
     */
    if (device->current.event_in.type == EV_LED)
    {
        switch (device->current.event_in.code)
        {
            case LED_CAPSL:
                if (device->current.event_in.value == 0) device->lock_state &= ~LIRCUDEVD_KEYMAP_CAPSLOCK;
                else                                     device->lock_state !=  LIRCUDEVD_KEYMAP_CAPSLOCK;
                device->current.event_out.type = LIRCUDEVD_EV_NULL;
                device->current.repeat_count = 0;
                return 0;
                break;
            case LED_NUML:
                if (device->current.event_in.value == 0) device->lock_state &= ~LIRCUDEVD_KEYMAP_NUMLOCK;
                else                                     device->lock_state !=  LIRCUDEVD_KEYMAP_NUMLOCK;
                device->current.event_out.type = LIRCUDEVD_EV_NULL;
                device->current.repeat_count = 0;
                return 0;
                break;
            case LED_SCROLLL:
                if (device->current.event_in.value == 0) device->lock_state &= ~LIRCUDEVD_KEYMAP_SCROLLLOCK;
                else                                     device->lock_state !=  LIRCUDEVD_KEYMAP_SCROLLLOCK;
                device->current.event_out.type = LIRCUDEVD_EV_NULL;
                device->current.repeat_count = 0;
                return 0;
                break;
        }
    }

////////////////////////////////////////////////////////////////////////////////
    /*
     * lircudevd does not map non-key events. therefore, just set the output
     * event to the input event and return.
     */
    if (device->current.event_in.type != EV_KEY)
    {
        device->current.event_out    = device->current.event_in;
        device->current.repeat_count = 0;
        return 0;
    }

    /*
     * If it is a lock key code, then update the lock state, null
     * the current output event (as it has been handled) and return.
     */
    if (device->current.event_in.code == KEY_CAPSLOCK)
    {
        if (device->current.event_in.value == 1)
        {
            /*
             * Toggle the capslock status.
             */
            device->lock_state ^= LIRCUDEVD_KEYMAP_CAPSLOCK;
            /*
             * Update the device's capslock status.
             */
            if (device->led.capslock == true)
            {
                struct input_event event =
                {
                    .type  = EV_LED,
                    .code  = LED_CAPSL,
                    .value = ((device->lock_state & LIRCUDEVD_KEYMAP_CAPSLOCK) == 0) ? 0 : 1
                };
                if (write(device->fd, &event, sizeof(event)) != sizeof(event))
                {
                    syslog(LOG_WARNING, "failed to update capslock LED state for device %s: %s\n", device->path, strerror(errno));
                }
            }
        }
        device->current.event_out.type = LIRCUDEVD_EV_NULL;
        device->current.repeat_count = 0;
        return 0;
    }
    if (device->current.event_in.code == KEY_NUMLOCK)
    {
        if (device->current.event_in.value == 1)
        {
            /*
             * Toggle the numlock status.
             */
            device->lock_state ^= LIRCUDEVD_KEYMAP_NUMLOCK;
            /*
             * Update the device's numlock status.
             */
            if (device->led.numlock == true)
            {
                struct input_event event =
                {
                    .type  = EV_LED,
                    .code  = LED_NUML,
                    .value = ((device->lock_state & LIRCUDEVD_KEYMAP_NUMLOCK) == 0) ? 0 : 1
                };
                if (write(device->fd, &event, sizeof(event)) != sizeof(event))
                {
                    syslog(LOG_WARNING, "failed to update numlock LED state for device %s: %s\n", device->path, strerror(errno));
                }
            }
        }
        device->current.event_out.type = LIRCUDEVD_EV_NULL;
        device->current.repeat_count = 0;
        return 0;
    }
    if (device->current.event_in.code == KEY_SCROLLLOCK)
    {
        if (device->current.event_in.value == 1)
        {
            /*
             * Toggle the scrolllock status.
             */
            device->lock_state ^= LIRCUDEVD_KEYMAP_SCROLLLOCK;
            /*
             * Update the device's scrolllock status.
             */
            if (device->led.scrolllock == true)
            {
                struct input_event event =
                {
                    .type  = EV_LED,
                    .code  = LED_SCROLLL,
                    .value = ((device->lock_state & LIRCUDEVD_KEYMAP_SCROLLLOCK) == 0) ? 0 : 1
                };
                if (write(device->fd, &event, sizeof(event)) != sizeof(event))
                {
                    syslog(LOG_WARNING, "failed to update scrolllock LED state for device %s: %s\n", device->path, strerror(errno));
                }
            }
        }
        device->current.event_out.type = LIRCUDEVD_EV_NULL;
        device->current.repeat_count = 0;
        return 0;
    }

    /*
     * If it is a modifier key code, then update the modifier state, null
     * the current output event (as it has been handled) and return.
     */
    if ((device->current.event_in.code == KEY_LEFTCTRL ) || (device->current.event_in.code == KEY_RIGHTCTRL ))
    {
        if (device->current.event_in.value == 0) device->modifier_state &= ~LIRCUDEVD_KEYMAP_CTRL;
        else                                     device->modifier_state |=  LIRCUDEVD_KEYMAP_CTRL;
        memset(&(device->current.event_out), 0, sizeof(struct input_event));
        device->current.event_out.type = LIRCUDEVD_EV_NULL;
        device->current.repeat_count = 0;
        return 0;
    }
    if ((device->current.event_in.code == KEY_LEFTSHIFT) || (device->current.event_in.code == KEY_RIGHTSHIFT))
    {
        if (device->current.event_in.value == 0) device->modifier_state &= ~LIRCUDEVD_KEYMAP_SHIFT;
        else                                     device->modifier_state |=  LIRCUDEVD_KEYMAP_SHIFT;
        memset(&(device->current.event_out), 0, sizeof(struct input_event));
        device->current.event_out.type = LIRCUDEVD_EV_NULL;
        device->current.repeat_count = 0;
        return 0;
    }
    if ((device->current.event_in.code == KEY_LEFTALT  ) || (device->current.event_in.code == KEY_RIGHTALT  ))
    {
        if (device->current.event_in.value == 0) device->modifier_state &= ~LIRCUDEVD_KEYMAP_ALT;
        else                                     device->modifier_state |=  LIRCUDEVD_KEYMAP_ALT;
        memset(&(device->current.event_out), 0, sizeof(struct input_event));
        device->current.event_out.type = LIRCUDEVD_EV_NULL;
        device->current.repeat_count = 0;
        return 0;
    }
    if ((device->current.event_in.code == KEY_LEFTMETA ) || (device->current.event_in.code == KEY_RIGHTMETA ))
    {
        if (device->current.event_in.value == 0) device->modifier_state &= ~LIRCUDEVD_KEYMAP_META;
        else                                     device->modifier_state |=  LIRCUDEVD_KEYMAP_META;
        memset(&(device->current.event_out), 0, sizeof(struct input_event));
        device->current.event_out.type = LIRCUDEVD_EV_NULL;
        device->current.repeat_count = 0;
        return 0;
    }

////////////////////////////////////////////////////////////////////////////////
    /*
     * Map the current event.
     */
    if (input_device_keymap_run(device) < 0)
    {
        return -1;
    }
    if (device->current.event_out.code == LIRCUDEVD_KEYMAP_NULL)
    {
        memset(&(device->current.event_out), 0, sizeof(struct input_event));
        device->current.event_out.type = LIRCUDEVD_EV_NULL;
        device->current.repeat_count = 0;
        return 0;
    }

    switch (device->current.event_out.value)
    {
        /*
         * Process the key press event.
         */
        case 1:
            device->current.repeat_count = 0;
            /*
             * As this is a key press event, lircudevd will need later to map
             * correctly any corresponding key repeat and key release events.
             * Therefore, we push it onto the previous key press event list.
             * If we fail, then we discard the event as we will not be able to
             * map correctly any corresponding key repeat and key release
             * events.
             */
            if (input_device_previous_push(device) < 0)
            {
                memset(&(device->current.event_out), 0, sizeof(struct input_event));
                device->current.event_out.type = LIRCUDEVD_EV_NULL;
                device->current.repeat_count = 0;
                return -1;
            }
////////////////////////////////////////////////////////////////////////////////
            break;
        /*
         * Process the key repeat event.
         */
        case 2:
            if ((previous = input_device_previous_get(device)) == NULL)
            {
                memset(&(device->current.event_out), 0, sizeof(struct input_event));
                device->current.event_out.type = LIRCUDEVD_EV_NULL;
                device->current.repeat_count = 0;
                return 0;
            }
            device->current.event_out.type = previous->event_out.type;
            device->current.event_out.code = previous->event_out.code;
            /*
             * If the key repeat is too quick, then ignore it. The delay is
             * longer for the first repeat in order to allow the user to release
             * the key before repeating starts.
             */
            if (evkey_type[device->current.event_out.code] == LIRCUDEVD_EVKEY_TYPE_KEY)
            {
                time_delta = 1000000 * (device->current.event_out.time.tv_sec  - previous->event_out.time.tv_sec ) +
                                       (device->current.event_out.time.tv_usec - previous->event_out.time.tv_usec);
                if      ((previous->repeat_count == 0) && (time_delta < 500000))
                {
                    memset(&(device->current.event_out), 0, sizeof(struct input_event));
                    device->current.event_out.type = LIRCUDEVD_EV_NULL;
                    device->current.repeat_count = 0;
                    return 0;
                }
                else if ((previous->repeat_count >= 1) && (time_delta <  50000))
                {
                    memset(&(device->current.event_out), 0, sizeof(struct input_event));
                    device->current.event_out.type = LIRCUDEVD_EV_NULL;
                    device->current.repeat_count = 0;
                    return 0;
                }
            }
////////////////////////////////////////////////////////////////////////////////
            previous->repeat_count++;
            previous->event_out.time = device->current.event_out.time;
            device->current.repeat_count = previous->repeat_count;
            break;
        /*
         * Process the key release event.
         */
        case 0:
            if ((previous = input_device_previous_get(device)) == NULL)
            {
                memset(&(device->current.event_out), 0, sizeof(struct input_event));
                device->current.event_out.type = LIRCUDEVD_EV_NULL;
                device->current.repeat_count = 0;
                return 0;
            }
            device->current.event_out.type = previous->event_out.type;
            device->current.event_out.code = previous->event_out.code;

            device->current.repeat_count = 0;
            input_device_previous_pop(device);
            break;
        default:
            memset(&(device->current.event_out), 0, sizeof(struct input_event));
            device->current.event_out.type = LIRCUDEVD_EV_NULL;
            device->current.repeat_count = 0;
            break;
    }

    return 0;
}

static bool input_device_event_is_key(struct input_device *device)
{
    if (device == NULL)
    {
        errno = EINVAL;
        return false;
    }
    if (device->current.event_out.type != EV_KEY)
    {
        return false;
    }
    if (device->current.event_out.code > KEY_MAX)
    {
        return false;
    }
    if (evkey_type[device->current.event_out.code] != LIRCUDEVD_EVKEY_TYPE_KEY)
    {
        return false;
    }
    return true;
}

static int input_device_handler(void *id)
{
    struct input_device *device;
    struct input_event event;

    if (id == NULL)
    {
        errno = EINVAL;
        return -1;
    }

    device = (struct input_device *)id;

    if (read(device->fd, &event, sizeof(event)) != sizeof(event))
    {
        return 0;
    }

    input_device_event_update(device, &event);
    if (device->current.event_out.type == LIRCUDEVD_EV_NULL)
    {
        return 0;
    }

    /* 
     * Send keys to lircd and send all other events to the output device
     * (assuming it exists)
     */
    if (input_device_event_is_key(device) == true)
    {
        if (lircd_send(&device->current.event_out, evkey_code_to_name[device->current.event_out.code], device->current.repeat_count, device->path) != 0)
        {
            return -1;
        }
    }
    else if (device->output.fd != -1)
    {
        if (input_device_send(device, &device->current.event_out) != 0)
        {
            return -1;
        }
    }

    return 0;
}

static int input_device_close(struct input_device *device)
{
    int return_code;

    if (device == NULL)
    {
        errno = EINVAL;
        return -1;
    }

    return_code = 0;

    if (monitor_client_remove(device->fd) != 0)
    {
        return_code = -1;
    }

    if (device->output.fd != -1)
    {
        ioctl(device->output.fd, UI_DEV_DESTROY);
        close(device->output.fd);
        device->output.fd = -1;
        syslog(LOG_INFO, "destroyed output mouse/joystick device for input device %s", device->path);
    }
    if (device->fd != -1)
    {
        close(device->fd);
        device->fd = -1;
        syslog(LOG_INFO, "released input device %s", device->path);
    }
    if (device->path != NULL)
    {
        free(device->path);
        device->path = NULL;
    }

    return 0;
}

static int input_device_purge()
{
    struct input_device **device_ptr;
    struct input_device *device;
    int return_code;

    return_code = 0;

    device_ptr = &(lircudevd_input.device_list);
    while (*device_ptr != NULL)
    {
        device = *device_ptr;
        if (device->fd == -1)
        {
            *device_ptr = device->next;
            if (input_device_close(device) != 0)
            {
                free(device);
                return_code = -1;
            }
        }
        else
        {
            device_ptr = &((*device_ptr)->next);
        }
    }

    return return_code;
}

static int input_device_remove(struct udev_device *udev_device)
{
    const char* path = NULL;
    struct input_device *device;
    int return_code;

    if (udev_device == NULL)
    {
        errno = EINVAL;
        return -1;
    }

    path = udev_device_get_devnode(udev_device);
    if (path == NULL)
    {
        return 0;
    }

    return_code = 0;

    for (device = lircudevd_input.device_list ; device != NULL ; device = device->next)
    {
        if (device->path == NULL)
        {
            continue;
        }
        if (strncmp(device->path, path, PATH_MAX) == 0)
        {
            if (input_device_close(device) != 0)
            {
                return_code = -1;
            }
        }
    }
    if (input_device_purge() != 0)
    {
        return_code = -1;
    }

    return return_code;
}

static int input_device_add(struct udev_device *udev_device)
{
    const char *uinput_devname[] =
    {
        "/dev/uinput",
        "/dev/input/uinput",
        "/dev/misc/uinput",
        NULL
    };
    const char* name;
    const char* path;
    const char* enable;
    const char* keymap_file;
    struct input_device *device;
    unsigned long bit[BITFIELD_LONGS_PER_ARRAY(EV_MAX)];
    unsigned long bit_key[BITFIELD_LONGS_PER_ARRAY(KEY_MAX)];
    unsigned long bit_rel[BITFIELD_LONGS_PER_ARRAY(REL_MAX)];
    unsigned long bit_abs[BITFIELD_LONGS_PER_ARRAY(ABS_MAX)];
    unsigned long bit_msc[BITFIELD_LONGS_PER_ARRAY(MSC_MAX)];
    unsigned long bit_sw[BITFIELD_LONGS_PER_ARRAY(SW_MAX)];
    unsigned long bit_led[BITFIELD_LONGS_PER_ARRAY(LED_MAX)];
    unsigned long bit_snd[BITFIELD_LONGS_PER_ARRAY(SND_MAX)];
    unsigned long bit_ff[BITFIELD_LONGS_PER_ARRAY(FF_MAX)];
    unsigned long bit_ff_status[BITFIELD_LONGS_PER_ARRAY(FF_STATUS_MAX)];
    __u16 type;
    __u32 code;
    int i;
    int j;
    int k;
    bool output_active;

    if (udev_device == NULL)
    {
        errno = EINVAL;
        return -1;
    }

    name = udev_device_get_property_value(udev_device_get_parent(udev_device), "NAME");
    if ((name != NULL) && (strncmp(name, "\"lircudevd\"", strlen("\"lircudevd\"")) == 0))
    {
        return 0;
    }

    path = udev_device_get_devnode(udev_device);
    if (path == NULL)
    {
        return 0;
    }

    enable = udev_device_get_property_value(udev_device, "lircudevd.enable");
    if ((enable == NULL) ||(strncmp(enable, "true", sizeof("true")) != 0))
    {
        return 0;
    }

    keymap_file = udev_device_get_property_value(udev_device, "lircudevd.keymap");

    for (device = lircudevd_input.device_list ; device != NULL ; device = device->next)
    {
        if (strncmp(device->path, path, PATH_MAX) == 0)
        {
            return 0;
        }
    }

    if ((device = calloc(1, sizeof(struct input_device))) == NULL)
    {
        syslog(LOG_ERR, "failed to allocate memory for the input device %s: %s\n", path, strerror(errno));
        return -1;
    }
    if ((device->path = strndup(path, PATH_MAX)) == NULL)
    {
        syslog(LOG_ERR, "failed to allocate memory for the input device %s: %s\n", path, strerror(errno));
        free(device);
        return -1;
    }
    if ((device->fd = open(device->path, O_RDWR)) < 0)
    {
        syslog(LOG_ERR, "failed to open device %s: %s\n", device->path, strerror(errno));
        free(device->path);
        free(device);
        return -1;
    }
    if (ioctl(device->fd, EVIOCGRAB, 1) < 0)
    {
        syslog(LOG_ERR, "failed to grab device %s: %s\n", device->path, strerror(errno));
        close(device->fd);
        free(device->path);
        free(device);
        return -1;
    }

    if (input_device_keymap_init(device, lircudevd_input.keymap_dir, keymap_file) != 0)
    {
        close(device->fd);
        free(device->path);
        free(device);
        return -1;
    }

    /*
     * Query the input device for event types and codes that it supports.
     */
    memset(bit, 0, sizeof(bit));
    ioctl(device->fd, EVIOCGBIT(0, EV_MAX), bit);
    for (i = 1 ; i < EV_MAX ; i++)
    {
        if (BITFIELD_TEST(i, bit))
        {
            switch (i)
            {
                case EV_KEY:
                    memset(bit_key, 0, sizeof(bit_key));
                    ioctl(device->fd, EVIOCGBIT(EV_KEY, KEY_MAX), bit_key);
                    break;
                case EV_REL:
                    memset(bit_rel, 0, sizeof(bit_rel));
                    ioctl(device->fd, EVIOCGBIT(EV_REL, REL_MAX), bit_rel);
                    break;
                case EV_ABS:
                    memset(bit_abs, 0, sizeof(bit_abs));
                    ioctl(device->fd, EVIOCGBIT(EV_ABS, ABS_MAX), bit_abs);
                    break;
                case EV_MSC:
                    memset(bit_msc, 0, sizeof(bit_msc));
                    ioctl(device->fd, EVIOCGBIT(EV_MSC, MSC_MAX), bit_msc);
                    break;
                case EV_SW:
                    memset(bit_sw, 0, sizeof(bit_sw));
                    ioctl(device->fd, EVIOCGBIT(EV_SW, SW_MAX), bit_sw);
                    break;
                case EV_LED:
                    memset(bit_led, 0, sizeof(bit_led));
                    ioctl(device->fd, EVIOCGBIT(EV_LED, LED_MAX), bit_led);
                    break;
                case EV_SND:
                    memset(bit_snd, 0, sizeof(bit_snd));
                    ioctl(device->fd, EVIOCGBIT(EV_SND, SND_MAX), bit_snd);
                    break;
                case EV_REP:
                    break;
                case EV_FF:
                    memset(bit_ff, 0, sizeof(bit_ff));
                    ioctl(device->fd, EVIOCGBIT(EV_FF, FF_MAX), bit_ff);
                    break;
                case EV_FF_STATUS:
                    memset(bit_ff_status, 0, sizeof(bit_ff_status));
                    ioctl(device->fd, EVIOCGBIT(EV_FF_STATUS, FF_STATUS_MAX), bit_ff_status);
                    break;
                default:
                    break;
            }
        }
    }

    /*
     * Check for event types and codes that are not support by lircudevd.
     */
    for (i = 1 ; i < EV_MAX ; i++)
    {
        if (BITFIELD_TEST(i, bit))
        {
            switch (i)
            {
                case EV_KEY:
                    break;
                case EV_REL:
                    break;
                case EV_ABS:
                    break;
                case EV_MSC:
                    syslog(LOG_DEBUG,
                           "events of unsupported event type EV_MSC from %s will be discarded\n",
                           device->path);
                    for (j = 0 ; j < MSC_MAX ; j++)
                    {
                        if (BITFIELD_TEST(j, bit_msc) != 0)
                        {
                            syslog(LOG_DEBUG,
                                   "event code 0x%02x of unsupported event type EV_MSC from %s will be discarded\n",
                                   j, device->path);
                        }
                    }
                    break;
                case EV_SW:
                    syslog(LOG_DEBUG,
                           "events of unsupported event type EV_SW from %s will be discarded\n",
                           device->path);
                    for (j = 0 ; j < SW_MAX ; j++)
                    {
                        if (BITFIELD_TEST(j, bit_sw) != 0)
                        {
                            syslog(LOG_DEBUG,
                                   "event code 0x%02x of unsupported event type EV_SW from %s will be discarded\n",
                                   j, device->path);
                        }
                    }
                    break;
                case EV_LED:
                    for (j = 0 ; j < LED_MAX ; j++)
                    {
                        if ((j == LED_CAPSL  ) ||
                            (j == LED_NUML   ) ||
                            (j == LED_SCROLLL))
                        {
                            continue;
                        }
                        if (BITFIELD_TEST(j, bit_led) != 0)
                        {
                            syslog(LOG_DEBUG,
                                   "unsupported event code 0x%02x of event type EV_LED from %s will be discarded\n",
                                   j, device->path);
                        }
                    }
                    break;
                case EV_SND:
                    syslog(LOG_DEBUG,
                           "events of unsupported event type EV_SND from %s will be discarded\n",
                           device->path);
                    for (j = 0 ; j < SND_MAX ; j++)
                    {
                        if (BITFIELD_TEST(j, bit_snd) != 0)
                        {
                            syslog(LOG_DEBUG,
                                   "event code 0x%02x of unsupported event type EV_SND from %s will be discarded\n",
                                   j, device->path);
                        }
                    }
                    break;
                case EV_REP:
                    syslog(LOG_DEBUG,
                           "events of unsupported event type EV_REP from %s will be discarded\n",
                           device->path);
                    break;
                case EV_FF:
                    syslog(LOG_DEBUG,
                           "events of unsupported event type EV_FF from %s will be discarded\n",
                           device->path);
                    for (j = 0 ; j < FF_MAX ; j++)
                    {
                        if (BITFIELD_TEST(j, bit_ff) != 0)
                        {
                            syslog(LOG_DEBUG,
                                   "event code 0x%02x of unsupported event type EV_FF from %s will be discarded\n",
                                   j, device->path);
                        }
                    }
                    break;
                case EV_PWR:
                    syslog(LOG_DEBUG,
                           "events of unsupported event type EV_PWR from %s will be discarded\n",
                           device->path);
                    break;
                case EV_FF_STATUS:
                    syslog(LOG_DEBUG,
                           "events of unsupported event type EV_FF_STATUS from %s will be discarded\n",
                           device->path);
                    for (j = 0 ; j < FF_STATUS_MAX ; j++)
                    {
                        if (BITFIELD_TEST(j, bit_ff_status) != 0)
                        {
                            syslog(LOG_DEBUG,
                                   "event code 0x%02x of unsupported event type EV_FF_STATUS from %s will be discarded\n",
                                   j, device->path);
                        }
                    }
                    break;
                default:
                    syslog(LOG_DEBUG,
                           "events of unsupported event type 0x%02x from %s will be discarded\n",
                           type, device->path);
                    break;
            }
        }
    }

    device->led.capslock = false;
    device->led.numlock = false;
    device->led.scrolllock = false;
    if (BITFIELD_TEST(EV_LED, bit) != 0)
    {
        if (BITFIELD_TEST(LED_CAPSL, bit_led) != 0)
        {
            device->led.capslock = true;
        }
        if (BITFIELD_TEST(LED_NUML, bit_led) != 0)
        {
            device->led.numlock = true;
        }
        if (BITFIELD_TEST(LED_SCROLLL, bit_led) != 0)
        {
            device->led.scrolllock = true;
        }
    }
    device->lock_state = 0;

    device->modifier_state = 0;

    device->previous_list = NULL;
    memset(&(device->current.event_in), 0, sizeof(struct input_event));
    device->current.event_in.type = LIRCUDEVD_EV_NULL;
    memset(&(device->current.event_out), 0, sizeof(struct input_event));
    device->current.event_out.type = LIRCUDEVD_EV_NULL;
    device->current.repeat_count = 0;

    /* create output event device for events that are not consumed by LIRCD */
    device->output.fd = -1;
    for (i = 0 ; (device->output.fd == -1) && (uinput_devname[i] != NULL) ; i++)
    {
        device->output.fd = open(uinput_devname[i], O_WRONLY | O_NDELAY);
    }
    if (device->output.fd == -1)
    {
        syslog(LOG_ERR, "unable to open uinput device for input device %s: %s\n", device->path, strerror(errno));
        input_device_keymap_exit(device);
        close(device->fd);
        free(device->path);
        free(device);
        return -1;
    }

    memset(&(device->output.dev), 0, sizeof(device->output.dev));

    device->output.syn_report = false;

    strncpy(device->output.dev.name, DEVICE_NAME, UINPUT_MAX_NAME_SIZE - 1);
    device->output.dev.name[UINPUT_MAX_NAME_SIZE - 1] = '\0';
    if (ioctl(device->fd, EVIOCGID, &(device->output.dev.id)) != 0)
    {
        syslog(LOG_WARNING, "unable to retreive id information for input device %s: %s\n", device->path, strerror(errno));
        device->output.dev.id.bustype = 0;
        device->output.dev.id.vendor = 0;
        device->output.dev.id.product = 0;
        device->output.dev.id.version = 0;
    }

    if (ioctl(device->output.fd, UI_SET_PHYS, device->path) < 0)
    {
        syslog(LOG_ERR, "failed to set UI_SET_PHYS for %s: %s\n", device->path, strerror(errno));
        close(device->output.fd);
        input_device_keymap_exit(device);
        close(device->fd);
        free(device->path);
        free(device);
        return -1;
    }

    /*
     * Configure mouse/joystick device with the mapped event types and codes
     * that are supported by lircudevd.
     */
    output_active = false;
    for (i = 1 ; i < EV_MAX ; i++)
    {
        if (BITFIELD_TEST(i, bit))
        {
            if (i == 0)
            {
                continue;
            }
            switch (i)
            {
                case EV_KEY:
                    for (j = 0 ; j < KEY_MAX ; j++)
                    {
                        __u16 type = i;
                        __u16 code = j;
                        if (BITFIELD_TEST(code, bit_key) != 0)
                        {
                            /*
                             * If the key code is a lock key code, then skip it
                             * as lircudevd consumes it as part of keyboard
                             * shortcut mapping.
                             */
                            if ((code == KEY_CAPSLOCK  ) ||
                                (code == KEY_NUMLOCK   ) ||
                                (code == KEY_SCROLLLOCK))
                            {
                                continue;
                            }
                            /*
                             * If the key code is a modifier key code, then skip
                             * it as lircudevd consumes it as part of keyboard
                             * shortcut mapping.
                             */
                            if ((code == KEY_LEFTCTRL ) || (code == KEY_RIGHTCTRL ) ||
                                (code == KEY_LEFTSHIFT) || (code == KEY_RIGHTSHIFT) ||
                                (code == KEY_LEFTALT  ) || (code == KEY_RIGHTALT  ) ||
                                (code == KEY_LEFTMETA ) || (code == KEY_RIGHTMETA ))
                            {
                                continue;
                            }
                            /*
                             * Map the key code.
                             */
                            device->current.event_in.type = type;
                            device->current.event_in.code = code;
                            input_device_keymap_run(device);
                            /*
                             * The key code maps to NULL so move on to the next
                             * key code.
                             */
                            code = device->current.event_out.code;
                            if (code == LIRCUDEVD_KEYMAP_NULL)
                            {
                                continue;
                            }
                            /*
                             * The mapped key code is a button, so mark it as
                             * supported by the mouse/joystick device.
                             */
                            if (evkey_type[code] == LIRCUDEVD_EVKEY_TYPE_BTN)
                            {
                                if (ioctl(device->output.fd, UI_SET_EVBIT, EV_KEY) < 0)
                                {
                                    syslog(LOG_ERR,
                                           "failed to set UI_SET_EVBIT EV_KEY for %s: %s\n",
                                           device->path, strerror(errno));
                                }
                                if (ioctl(device->output.fd, UI_SET_KEYBIT, code) < 0)
                                {
                                    syslog(LOG_ERR,
                                           "failed to set UI_SET_KEYBIT 0x%02x for %s: %s\n",
                                           code, device->path, strerror(errno));
                                }
                                output_active = true;
                            }
                        }
                    }
                    break;
                case EV_REL:
                    for (j = 0 ; j < REL_MAX ; j++)
                    {
                        __u16 type = i;
                        __u16 code = j;
                        if (BITFIELD_TEST(code, bit_rel) != 0)
                        {
                            if (ioctl(device->output.fd, UI_SET_EVBIT, EV_REL) < 0)
                            {
                                syslog(LOG_ERR,
                                       "failed to set UI_SET_EVBIT EV_REL for %s: %s\n",
                                       device->path, strerror(errno));
                            }
                            if (ioctl(device->output.fd, UI_SET_RELBIT, code) < 0)
                            {
                                syslog(LOG_ERR,
                                       "failed to set UI_SET_RELBIT 0x%02x for %s: %s\n",
                                       code, device->path, strerror(errno));
                            }
                            output_active = true;
                        }
                    }
                    break;
                case EV_ABS:
                    for (j = 0 ; j < ABS_MAX ; j++)
                    {
                        __u16 type = i;
                        __u16 code = j;
                        if (BITFIELD_TEST(code, bit_abs) != 0)
                        {
                            struct input_absinfo absinfo;
                            if (ioctl(device->output.fd, UI_SET_EVBIT, EV_ABS) < 0)
                            {
                                syslog(LOG_ERR,
                                       "failed to set UI_SET_EVBIT EV_ABS for %s: %s\n",
                                       device->path, strerror(errno));
                            }
                            if (ioctl(device->output.fd, UI_SET_ABSBIT, code) < 0)
                            {
                                syslog(LOG_ERR,
                                       "failed to set UI_SET_ABSBIT 0x%02x for %s: %s\n",
                                       code, device->path, strerror(errno));
                            }
                            if (ioctl(device->fd, EVIOCGABS(code), &absinfo) < 0)
                            {
                                syslog(LOG_ERR,
                                       "failed to get ABS information for 0x%02x of %s: %s\n",
                                       code, device->path, strerror(errno));
                            }
                            else
                            {
                                device->output.dev.absmax[code] = absinfo.maximum;
                                device->output.dev.absmin[code] = absinfo.minimum;
                                device->output.dev.absfuzz[code] = absinfo.fuzz;
                                device->output.dev.absflat[code] = absinfo.flat;
                            }
                            output_active = true;
                        }
                    }
                    break;
                case EV_MSC:
                    break;
                case EV_SW:
                    break;
                case EV_LED:
                    break;
                case EV_SND:
                    break;
                case EV_REP:
                    break;
                case EV_FF:
                    break;
                case EV_FF_STATUS:
                    break;
            }
        }
    }
    /*
     * Make sure that any buttos that are the result of keyboard shortcut
     * mapping are included in the mouse/joystick device.
     */
    if (BITFIELD_TEST(EV_KEY, bit) != 0)
    {
        for (i = 0 ; i < device->keymap_size ; i++)
        {
            __u16 code_in  = device->keymap[i].code_in;
            __u16 code_out = device->keymap[i].code_out;
            /*
             * Skip keyboard shortcuts that map to NULL.
             */
            if (code_out == LIRCUDEVD_KEYMAP_NULL)
            {
                continue;
            }
            /*
             * Ignore keyboard shortcuts that require keys the device
             * does not support.
             */
            if (((code_in & LIRCUDEVD_KEYMAP_CAPSLOCK) != 0) &&
                (BITFIELD_TEST(KEY_CAPSLOCK, bit_key)  == 0))
            {
               continue;
            }
            if (((code_in & LIRCUDEVD_KEYMAP_NUMLOCK) != 0) &&
                (BITFIELD_TEST(KEY_NUMLOCK, bit_key)  == 0))
            {
               continue;
            }
            if (((code_in & LIRCUDEVD_KEYMAP_SCROLLLOCK) != 0) &&
                (BITFIELD_TEST(KEY_SCROLLLOCK, bit_key)  == 0))
            {
               continue;
            }
            if (((code_in & LIRCUDEVD_KEYMAP_CTRL)     != 0) &&
                (BITFIELD_TEST(KEY_LEFTCTRL, bit_key)  == 0) &&
                (BITFIELD_TEST(KEY_RIGHTCTRL, bit_key) == 0))
            {
               continue;
            }
            if (((code_in & LIRCUDEVD_KEYMAP_SHIFT)     != 0) &&
                (BITFIELD_TEST(KEY_LEFTSHIFT, bit_key)  == 0) &&
                (BITFIELD_TEST(KEY_RIGHTSHIFT, bit_key) == 0))
            {
               continue;
            }
            if (((code_in & LIRCUDEVD_KEYMAP_ALT)     != 0) &&
                (BITFIELD_TEST(KEY_LEFTALT, bit_key)  == 0) &&
                (BITFIELD_TEST(KEY_RIGHTALT, bit_key) == 0))
            {
               continue;
            }
            if (((code_in & LIRCUDEVD_KEYMAP_META)     != 0) &&
                (BITFIELD_TEST(KEY_LEFTMETA, bit_key)  == 0) &&
                (BITFIELD_TEST(KEY_RIGHTMETA, bit_key) == 0))
            {
               continue;
            }
            if (BITFIELD_TEST(code_in & LIRCUDEVD_KEYMAP_KEY, bit_key) == 0)
            {
                continue;
            }
            /*
             * The output is a button so add it to mouse/joystick device.
             */
            if (evkey_type[code_out] == LIRCUDEVD_EVKEY_TYPE_BTN)
            {
                if (ioctl(device->output.fd, UI_SET_EVBIT, EV_KEY) < 0)
                {
                    syslog(LOG_ERR,
                           "failed to set UI_SET_EVBIT EV_KEY for %s: %s\n",
                           device->path, strerror(errno));
                }
                if (ioctl(device->output.fd, UI_SET_KEYBIT, code_out) < 0)
                {
                    syslog(LOG_ERR,
                           "failed to set UI_SET_KEYBIT 0x%02x for %s: %s\n",
                           code_out, device->path, strerror(errno));
                }
                output_active = true;
            }
        }
    }
    /*
     *
     */
    if (output_active == true)
    {
        write(device->output.fd, &device->output.dev, sizeof(device->output.dev));
        if (ioctl(device->output.fd, UI_DEV_CREATE))
        {
            syslog(LOG_ERR,
                   "unable to create uinput device for %s: %s\n",
                   device->path, strerror(errno));
            close(device->output.fd);
            input_device_keymap_exit(device);
            close(device->fd);
            free(device->path);
            free(device);
            return -1;
        }
    }
    else
    {
        close(device->output.fd);
        device->output.fd = -1;
    }

    /*
     * Make sure we recieve notifications when the device has changed state.
     */
    if (monitor_client_add(device->fd, &input_device_handler, device) != 0)
    {
        close(device->output.fd);
        input_device_keymap_exit(device);
        close(device->fd);
        free(device->path);
        free(device);
        return -1;
    }

    /*
     * Make sure that our state matches the device's state for capslock, numlock
     * and scrolllock.
     */
    if ((device->led.capslock   == true) || 
        (device->led.numlock    == true) ||
        (device->led.scrolllock == true))
    {
        int8_t bit[LED_MAX/8 + 1];
        memset(bit, 0, sizeof(bit));
        ioctl(device->fd, EVIOCGLED(sizeof(bit)), bit);
        if (device->led.capslock == true)
        {
            if (((bit[LED_CAPSL/8] >> (LED_CAPSL%8)) & 0x1) == 0) device->lock_state &= ~LIRCUDEVD_KEYMAP_CAPSLOCK;
            else                                                  device->lock_state !=  LIRCUDEVD_KEYMAP_CAPSLOCK;
        }
        if (device->led.numlock == true)
        {
            if (((bit[LED_NUML/8] >> (LED_NUML%8)) & 0x1) == 0) device->lock_state &= ~LIRCUDEVD_KEYMAP_NUMLOCK;
            else                                                device->lock_state !=  LIRCUDEVD_KEYMAP_NUMLOCK;
        }
        if (device->led.scrolllock == true)
        {
            if (((bit[LED_SCROLLL/8] >> (LED_SCROLLL%8)) & 0x1) == 0) device->lock_state &= ~LIRCUDEVD_KEYMAP_SCROLLLOCK;
            else                                                      device->lock_state !=  LIRCUDEVD_KEYMAP_SCROLLLOCK;
        }
    }

    device->next = lircudevd_input.device_list;
    lircudevd_input.device_list = device;

    syslog(LOG_INFO, "grabbed input device %s", device->path);
    if (device->output.fd != -1)
    {
        syslog(LOG_INFO, "created output mouse/joystick device for input device %s", device->path);
    }

    return 0;
}

static int input_handler(void *id)
{
    struct udev_device *udev_device;
    const char *action;

    if (lircudevd_input.udev.monitor == NULL)
    {
        return -1;
    }

    udev_device = udev_monitor_receive_device(lircudevd_input.udev.monitor);
    if (udev_device == NULL)
    {
        return -1;
    }

    action = udev_device_get_action(udev_device);
    if (action == NULL)
    {
        ;
    }
    else if (strncmp(action, "add", strlen("add") + 1) == 0)
    {
        if (input_device_add(udev_device) != 0)
        {
            return -1;
        }
    }
    else if (strncmp(action, "remove", strlen("remove") + 1) == 0)
    {
        if (input_device_remove(udev_device) != 0)
        {
            return -1;
        }
    }

    udev_device_unref(udev_device);

    return 0;
}

int input_exit()
{
    struct udev *udev = NULL;
    int return_code;
    struct input_device *device;

    return_code = 0;

    if (monitor_client_remove(lircudevd_input.udev.fd) != 0)
    {
        return_code = -1;
    }

    for (device = lircudevd_input.device_list ; device != NULL ; device = device->next)
    {
        if (input_device_close(device) != 0)
        {
            return_code = -1;
        }
    }
    if (input_device_purge() != 0)
    {
        return_code = -1;
    }

    if (lircudevd_input.udev.monitor != NULL)
    {
        udev = udev_monitor_get_udev(lircudevd_input.udev.monitor);
        udev_monitor_unref(lircudevd_input.udev.monitor);
        lircudevd_input.udev.monitor = NULL;
        if (udev != NULL)
        {
            udev_unref(udev);
        }
        else
        {
            return_code = -1;
        }
    }
    lircudevd_input.udev.fd = -1;

    if (lircudevd_input.keymap_dir != NULL)
    {
        free(lircudevd_input.keymap_dir);
        lircudevd_input.keymap_dir = NULL;
    }

    return return_code;
}

int input_init(const char *keymap_dir)
{
    struct udev *udev;
    struct udev_enumerate *enumerate;
    struct udev_list_entry *device_list;
    struct udev_list_entry *device;
    const char *syspath;
    struct udev_device *udev_device;
    const char *name;

    lircudevd_input.keymap_dir = NULL;
    lircudevd_input.udev.fd = -1;
    lircudevd_input.udev.monitor = NULL;
    lircudevd_input.device_list = NULL;

    if (keymap_dir == NULL)
    {
        errno = EINVAL;
        return -1;
    }

    if ((lircudevd_input.keymap_dir = strndup(keymap_dir, PATH_MAX + 1)) == NULL)
    {
        syslog(LOG_ERR, "failed to allocate memory for the input device key map directory name %s: %s\n", keymap_dir, strerror(errno));
        input_exit();
        return -1;
    }

    if ((udev = udev_new()) == NULL)
    {
        syslog(LOG_ERR, "failed to bind the udev monitor: %s\n", strerror(errno));
        input_exit();
        return -1;
    }

    if ((lircudevd_input.udev.monitor = udev_monitor_new_from_netlink(udev, "udev")) == NULL)
    {
        syslog(LOG_ERR, "failed to bind the udev monitor: %s\n", strerror(errno));
        input_exit();
        return -1;
    }

    if ((lircudevd_input.udev.fd = udev_monitor_get_fd(lircudevd_input.udev.monitor)) == -1)
    {
        syslog(LOG_ERR, "failed to get udev monitor file descriptor: %s\n", strerror(errno));
        input_exit();
        return -1;
    }

    if (udev_monitor_filter_add_match_subsystem_devtype(lircudevd_input.udev.monitor, "input", NULL) < 0)
    {
        syslog(LOG_ERR, "failed to bind the udev monitor: %s\n", strerror(errno));
        input_exit();
        return -1;
    }

    if (udev_monitor_enable_receiving(lircudevd_input.udev.monitor))
    {
        syslog(LOG_ERR, "failed to bind the udev monitor: %s\n", strerror(errno));
        input_exit();
        return -1;
    }

    if ((enumerate = udev_enumerate_new(udev)) == NULL)
    {
        syslog(LOG_ERR, "failed to enumerate udev devices: %s\n", strerror(errno));
        input_exit();
        return -1;
    }
    
    udev_enumerate_add_match_subsystem(enumerate, "input");
    udev_enumerate_scan_devices(enumerate);
    device_list = udev_enumerate_get_list_entry(enumerate);
    udev_list_entry_foreach(device, device_list)
    {
        if ((syspath = udev_list_entry_get_name(device)) == NULL)
        {
            input_exit();
            return -1;
        }
        if ((udev_device = udev_device_new_from_syspath(udev, syspath)) == NULL)
        {
            input_exit();
            return -1;
        }
        if (input_device_add(udev_device) != 0)
        {
            input_exit();
            return -1;
        }
        udev_device_unref(udev_device);
    }
    udev_enumerate_unref(enumerate);

    if (monitor_client_add(lircudevd_input.udev.fd, &input_handler, NULL) != 0)
    {
        input_exit();
        return -1;
    }

    return 0;
}
