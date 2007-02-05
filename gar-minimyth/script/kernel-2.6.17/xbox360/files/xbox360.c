/*
 * X-Box 360 controller - version 0.0.1
 *
 * Copyright (c) 2007 Paul Bender <pebender@gmail.com>
 *               2002 Marko Friedemann <mfr@bmx-chemnitz.de>
 *
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public License as
 * published by the Free Software Foundation; either version 2 of
 * the License, or (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 *
 *
 * This driver is based on:
 *   - the xpad driver - drivers/usb/input/xpad.c (version 0.0.5)
 *
 * This driver was made possible by information found on the
 * following websites:
 *   <http://wiki.free60.org/Gamepad>
 *   <http://euc.jp/periphs/xbox-controller.en.html>
 *
 * This driver was written more out of curiousity than need.
 * There is at least one Xbox 360 controller Linux driver.
 * However, I was interested in writing a Linux driver and using
 * the sys filesystem, and I wanted an Xbox 360 driver with
 * LED and rumble support.
 *
 * History:
 *
 * 2007-01-04 - 0.0.1 : first version
 *   - Replaced xpad's Xbox controller support with
 *     Xbox 360 support.
 *   - Added sys file system support for manipulating
 *     driver controls.
 *   - Added LED support that is controlled through the
 *     sys file system.
 *   - Added rumbler support that is controlled through
 *     the sys file system.
 */

#include <linux/version.h>
#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,19)
#include <linux/config.h>
#endif
#include <linux/kernel.h>
#include <linux/input.h>
#include <linux/init.h>
#include <linux/slab.h>
#include <linux/module.h>
#include <linux/smp_lock.h>
#include <linux/usb.h>
#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,18)
#include <linux/usb_input.h>
#else
#include <linux/usb/input.h>
#endif

#define DRIVER_VERSION "0.0.1"
#define DRIVER_AUTHOR "Paul Bender <pebender@gmail.com>"
#define DRIVER_DESC "Xbox 360 controller driver"

#define XPAD_PKT_LEN 32

#define DPAD_MIN           (-1)
#define DPAD_MAX           (+1)
#define DPAD_NOISE         (0)
#define DPAD_THRESHHOLD    (0)
#define TRIGGER_MIN        (0*0)      /* trigger values are squared to increase low end sensitivity */
#define TRIGGER_MAX        (255*255)
#define TRIGGER_NOISE      (0*0)
#define TRIGGER_THRESHHOLD (32*32)
#define THUMB_MIN          (-32768)
#define THUMB_MAX          (+32767)
#define THUMB_NOISE        (16)
#define THUMB_THRESHHOLD   (8192)

static int xbox360_sysfs_add(struct input_dev *dev);
static void xbox360_sysfs_remove(struct input_dev *dev);

static unsigned long debug = 0;
module_param(debug, ulong, 0644);
MODULE_PARM_DESC(debug, "Debug.");

static struct xbox360_device_type {
	u16 idVendor;
	u16 idProduct;
	char *name;
} xbox360_device_types[] = {
	{ 0x045e, 0x028e, "Microsoft Xbox 360 Controller"},	/* Microsoft Xbox 360 controller */
	{ 0x0000, 0x0000, "failure" }				/* Terminating entry */
};

struct xbox360_device {
	struct xbox360_device_type *type;	/* Xbox 360 device type */
	struct input_dev *dev;			/* Input device interface */
	struct usb_device *udev;		/* Usb device */

	struct urb *irq_in;			/* Urb for interrupt in report */
	unsigned char *idata;			/* Input data */
	dma_addr_t idata_dma;

	char phys[65];				/* Physical device path */

						/* These four controls are hard coded */
	int dpad_as_hat;			/* Control whether or not the d-pad is mapped to a hat device */
	int dpad_as_button;			/* Control whether or not the dpad is mapped to four buttons */
	int trigger_as_trigger;			/* Control whether or not the triggers are mapped to triggers */
	int trigger_as_button;			/* Control whether or not the triggers are mapped to buttons */

						/* These three controls are controlled through the sys file system */
	unsigned char led;			/* LED control value */
	unsigned char rumble_big;		/* Big rumble motor control value */
	unsigned char rumble_small;		/* Small rumble motor control value */
};


static const signed short xbox360_btn[] = {
	BTN_A,		/* Xbox 360 A button - Windows identifies as button 1 */
	BTN_B,		/* Xbox 360 B button - Windows identifies as button 2 */
	BTN_X,		/* Xbox 360 X button - Windows identifies as button 3 */
	BTN_Y,		/* Xbox 360 Y button - Windows identifies as button 4 */
	BTN_TL,		/* Xbox 360 LB button - Windows identifies as button 5 */
	BTN_TR,		/* Xbox 360 RB button - Windows identifies as button 6 */
	BTN_BACK,	/* Xbox 360 BACK button - Windows identifies as button 7 */
	BTN_START,	/* Xbox 360 START button - Windows identifies as button 8 */
	BTN_THUMBL,	/* Xbox 360 left thumb stick - Windows identifies as button 9 */
	BTN_THUMBR,	/* Xbox 360 right thumb stick - Windows identifies as button 10 */
	BTN_SELECT,	/* Xbox 360 guide (big X logo) button - Windows does not identify */
			/* Buttons created by mapping Xbox 360 triggers to buttons */
	BTN_TL2,	/* Xbox 360 LT trigger */
	BTN_TR2,	/* Xbox 360 RT trigger */
			/* Buttons created by mapping Xbox 360 directional-pad to buttons */
	BTN_0,		/* Xbox 360 directional-pad up */
	BTN_1,		/* Xbox 360 directional-pat right */
	BTN_2,		/* Xbox 360 directional-pat down */
	BTN_3,		/* Xbox 360 directional-pat left */
	-1		/* Terminating entry */
};

static const signed short xbox360_abs[] = {
	ABS_HAT0X,	/* Xbox 360 directional-pad X axis - Windows identifies as hat X axis */
	ABS_HAT0Y,	/* Xbox 360 Directional-pad Y axis - Windows identifies as hat Y axis */
	ABS_X,		/* Xbox 360 left thumb stick X axis - Windows identifies as X turn */
	ABS_Y,		/* Xbox 360 left thumb stick X axis - Windows identifies as Y turn */
	ABS_RX,		/* Xbox 360 right thumb stick X axis - Windows identifies as X rotate */
	ABS_RY,		/* Xbox 360 right thumb stick Y axis - Windows identifies as Y rotate */
	ABS_Z, 		/* Xbox 360 LT trigger - Windows identifies as +Z rotate */
	ABS_RZ,		/* Xbox 360 RT trigger - Windows identifies as -Z rotate */
	-1		/* terminating entry */
};

static struct usb_device_id xbox360_table [] = {
	{ USB_INTERFACE_INFO( 255 ,  93 , 1) },	/* Microsoft Xbox 360 */
	{ }
};

MODULE_DEVICE_TABLE (usb, xbox360_table);

/*
 * Because this uses 'usb_bulk_msg', which is synchronous, this routine
 * cannot be called from within any interrupt handler routine.
 */
static void xbox360_rumble_set(struct xbox360_device *xbox360)
{
	const int endpoint = 2;
	const unsigned char message_type   = 0;
	const unsigned char message_length = 8;
	unsigned char message[] = { message_type, message_length, 0, xbox360->rumble_big, xbox360->rumble_small, 0, 0, 0 };
	int  message_length_actual;

	usb_bulk_msg(
		xbox360->udev,
		usb_sndintpipe(xbox360->udev, endpoint),
		message,
		message_length,
		&message_length_actual,
		0);
}

/*
 * Valid LED state (led) values are given below.
 * I have yet to decipher the fallback behavior completely.
 * As a result, these descriptions may not completely accurate.
 *
 *  0. Turn off all LEDs.
 *  1. LED all: blink three times. Revert to fallback.
 *  2. LED 1: blink three times, turn on and become fallback.
 *  3. LED 2: blink three times, turn on and become fallback.
 *  4. LED 3: blink three times, turn on and become fallback.
 *  5. LED 4: blink three times, turn on and become fallback.
 *  6. LED 1: Turn on and become fallback.
 *  7. LED 2: Turn on and become fallback.
 *  8. LED 3: Turn on and become fallback.
 *  9. LED 4: Turn on and become fallback.
 * 10. LED all: rotate clockwise (i.e. 1 - 2 - 4 - 3).
 * 11. Fallback: Blink LED u5 times and then turn on previous.
 * 12. LED all: Slowly blink.
 * 13. Alternate all LEDs (1+4 - 2+3) fifteen times. Revert to fallback.
 * 14. LED all: Flash.
 * 15. LED all: Turn on, turn off and become fallback.
 *
 * Because this uses 'usb_bulk_msg', which is synchronous, this routine
 * cannot be called from within any interrupt handler routine.
 */
static void xbox360_led_set(struct xbox360_device *xbox360)
{
	const int endpoint = 2;
	const unsigned char message_type   = 1;
	const unsigned char message_length = 3;
	unsigned char message[] = { message_type, message_length, xbox360->led };
	int  message_length_actual;

	usb_bulk_msg(
		xbox360->udev,
		usb_sndintpipe(xbox360->udev, endpoint),
		message,
		message_length,
		&message_length_actual,
		0);
}

/*
 *	xbox360_process_packet
 *
 *	Completes a request by converting the data into events for the
 *	input subsystem.
 *
 *	Byte	Bit	Parameter
 *	0	7-0
 *	1	7-0	Length in bytes - always 20.
 *	2	0	Xbox 360 directional-pad up.
 *	2	1	Xbox 360 directional-pad down.
 *	2	2	Xbox 360 directional-pad left.
 *	2	3	Xbox 360 directional-pad right.
 *	2	4	Xbox 360 START button.
 *	2	5	Xbox 360 BACK button.
 *	2	6	Xbox 360 left thumb stick button.
 *	2	7	Xbox 360 right thumb stick button.
 *	3	0	Xbox 360 LB button.
 *	3	1	Xbox 360 RB button.
 *	3	2	Xbox 360 guide (big X logo) button.
 *	3	3
 *	3	4	Xbox 360 A button.
 *	3	5	Xbox 360 B button.
 *	3	6	Xbox 360 X button.
 *	3	7	Xbox 360 Y button.
 *	4	7-0	Xbox 360 LT trigger.
 *	5	7-0	Xbox 360 RT trigger.
 *	6	7-0	Xbox 360 left thumb stick X axis least significant byte.
 *	7	7-0	Xbox 360 left thumb stick X axis most significant byte.
 *	8	7-0	Xbox 360 left thumb stick Y axis least significant byte (bit flipped).
 *	9	7-0	Xbox 360 left thumb stick Y axis most significant byte (bit flipped).
 *	10	7-0	Xbox 360 left thumb stick Y axis least significant byte.
 *	11	7-0	Xbox 360 left thumb stick Y axis most significant byte.
 *	12	7-0	Xbox 360 left thumb stick X axis least significant byte.
 *	13	7-0	Xbox 360 left thumb stick y axis most significant byte.
 *	14
 *	15
 *	16
 *	17
 *	18
 *	19
 *
 *	Button values are 0 when not pressed and 1 when pressed.
 *	Directional-pad values are 0 when not pressed and 1 when pressed.
 *	Trigger values are in the range [0,255].
 *	Stick values are in the range [-32768,+32767].
 */

#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,19)
static void xbox360_process_packet(struct xbox360_device *xbox360, u16 cmd, unsigned char *data, struct pt_regs *regs)
#else
static void xbox360_process_packet(struct xbox360_device *xbox360, u16 cmd, unsigned char *data)
#endif
{
	int button_guide, button_back, button_start;
	int button_a, button_b, button_x, button_y;
	int button_lb, button_rb;
	int trigger_lt, trigger_rt, button_lt, button_rt;
	int dpad_up, dpad_down, dpad_left, dpad_right, dpad_x, dpad_y;
	int thumb_left_x, thumb_left_y, button_thumb_left, thumb_right_x, thumb_right_y, button_thumb_right;

#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,19)
	input_regs(xbox360->dev, regs);
#endif

	if (debug) {
		int i;

		pr_info("xbox360: rx packet: ");
		for (i = 0 ; i < data[1] ; i++ ) {
			printk("%02x ", data[i]);
		}
		printk("\n");
	}

	/* Extract button, trigger and thumb stick values */
	dpad_up            = (data[2] >> 0) & 0x1;
	dpad_down          = (data[2] >> 1) & 0x1;
	dpad_left          = (data[2] >> 2) & 0x1;
	dpad_right         = (data[2] >> 3) & 0x1;
	button_start       = (data[2] >> 4) & 0x1;
	button_back        = (data[2] >> 5) & 0x1;
	button_thumb_left  = (data[2] >> 6) & 0x1;
	button_thumb_right = (data[2] >> 7) & 0x1;
	button_lb          = (data[3] >> 0) & 0x1;
	button_rb          = (data[3] >> 1) & 0x1;
	button_guide       = (data[3] >> 2) & 0x1;
	button_a           = (data[3] >> 4) & 0x1;
	button_b           = (data[3] >> 5) & 0x1;
	button_x           = (data[3] >> 6) & 0x1;
	button_y           = (data[3] >> 7) & 0x1;
	trigger_lt         = (__u8)data[4];
	trigger_rt         = (__u8)data[5];
	thumb_left_x       = (__s16)((__s16)data[7]  << 8) | ((__s16)data[6]  << 0);
	thumb_left_y       = (__s16)((__s16)data[9]  << 8) | ((__s16)data[8]  << 0);
	thumb_right_x      = (__s16)((__s16)data[11] << 8) | ((__s16)data[10] << 0);
	thumb_right_y      = (__s16)((__s16)data[13] << 8) | ((__s16)data[12] << 0);

	/* Square triggers to make them more sensitive at the low end. */
	trigger_lt = trigger_lt * trigger_lt;
	trigger_rt = trigger_rt * trigger_rt;

	/* Create derived values */
	button_lt = ((trigger_lt < TRIGGER_THRESHHOLD) || (trigger_lt == 0)) ? 0 : 1;
	button_rt = ((trigger_rt < TRIGGER_THRESHHOLD) || (trigger_rt == 0)) ? 0 : 1;
	dpad_x    = dpad_right - dpad_left;
	dpad_y    = dpad_up - dpad_down;

	/* Mask values based on flags */
	if ( ! xbox360->dpad_as_hat ) { dpad_x = 0 ; dpad_y = 0; }
	if ( ! xbox360->dpad_as_button) { dpad_up = 0 ; dpad_down = 0; dpad_left = 0; dpad_right = 0; }
	if ( ! xbox360->trigger_as_trigger ) { trigger_lt = 0 ; trigger_rt = 0; }
	if ( ! xbox360->trigger_as_button ) { button_lt = 0 ; button_rt = 0; }

	if (debug) {
		pr_info("xbox360: processed rx packet:\n");
		if (button_a          ) pr_info("  button_a\n"          );
		if (button_b          ) pr_info("  button_b\n"          );
		if (button_x          ) pr_info("  button_x\n"          );
		if (button_y          ) pr_info("  button_y\n"          );
		if (button_guide      ) pr_info("  button_guide\n"      );
		if (button_back       ) pr_info("  button_back\n"       );
		if (button_start      ) pr_info("  button_start\n"      );
		if (button_lb         ) pr_info("  button_lb\n"         );
		if (button_rb         ) pr_info("  button_rb\n"         );
		if (button_lt         ) pr_info("  button_lt\n"         );
		if (button_rt         ) pr_info("  button_rt\n"         );
		if (dpad_up           ) pr_info("  dpad_up\n"           );
		if (dpad_down         ) pr_info("  dpad_down\n"         );
		if (dpad_left         ) pr_info("  dpad_left\n"         );
		if (dpad_right        ) pr_info("  dpad_right\n"        );
		if (button_thumb_left ) pr_info("  button_thumb_left\n" );
		if (button_thumb_right) pr_info("  button_thumb_right\n");
		if (trigger_lt        ) pr_info("  trigger_lt: 0x%04x (0x%08x)\n"  , abs(trigger_lt   ), (trigger_lt    <0)?-1:+1);
		if (trigger_rt        ) pr_info("  trigger_rt: 0x%04x (0x%08x)\n"  , abs(trigger_rt   ), (trigger_rt    <0)?-1:+1);
		if (dpad_x            ) pr_info("  dpad_x: 0x%04x (0x%08x)\n"      , abs(dpad_x       ), (dpad_x        <0)?-1:+1);
		if (dpad_y            ) pr_info("  dpad_y: 0x%04x (0x%08x)\n"      , abs(dpad_y       ), (dpad_y        <0)?-1:+1);
		if (thumb_left_x      ) pr_info("  thumb_left_x: 0x%04x (0x%08x)\n", abs(thumb_left_x ), (thumb_left_x  <0)?-1:+1);
		if (thumb_left_y      ) pr_info("  thumb_left_y: 0x%04x (0x%08x)\n", abs(thumb_left_y ), (thumb_left_y  <0)?-1:+1);
		if (thumb_right_x     ) pr_info("  thumb_right_x:0x%04x (0x%08x)\n", abs(thumb_right_x), (thumb_right_x <0)?-1:+1);
		if (thumb_right_y     ) pr_info("  thumb_right_y:0x%04x (0x%08x)\n", abs(thumb_right_y), (thumb_right_y <0)?-1:+1);
	}

	/* Send values to the input sub-system */
	input_report_abs(xbox360->dev, ABS_HAT0Y,  dpad_x);
	input_report_abs(xbox360->dev, ABS_HAT0X,  dpad_y);
	input_report_key(xbox360->dev, BTN_0,      dpad_up);
	input_report_key(xbox360->dev, BTN_1,      dpad_right);
	input_report_key(xbox360->dev, BTN_2,      dpad_down);
	input_report_key(xbox360->dev, BTN_3,      dpad_left);
	input_report_key(xbox360->dev, BTN_START,  button_start);
	input_report_key(xbox360->dev, BTN_BACK,   button_back);
	input_report_key(xbox360->dev, BTN_THUMBL, button_thumb_left);
	input_report_key(xbox360->dev, BTN_THUMBR, button_thumb_right);
	input_report_key(xbox360->dev, BTN_TL,     button_lb);
	input_report_key(xbox360->dev, BTN_TR,     button_rb);
	input_report_key(xbox360->dev, BTN_SELECT, button_guide);
	input_report_key(xbox360->dev, BTN_A,      button_a);
	input_report_key(xbox360->dev, BTN_B,      button_b);
	input_report_key(xbox360->dev, BTN_X,      button_x);
	input_report_key(xbox360->dev, BTN_Y,      button_y);
	input_report_abs(xbox360->dev, ABS_Z,      trigger_lt);
	input_report_abs(xbox360->dev, ABS_RZ,     trigger_rt);
	input_report_key(xbox360->dev, BTN_TL2,    button_lt);
	input_report_key(xbox360->dev, BTN_TR2,    button_rt);
	input_report_abs(xbox360->dev, ABS_X,      thumb_left_x);
	input_report_abs(xbox360->dev, ABS_Y,      thumb_left_y);
	input_report_abs(xbox360->dev, ABS_RX,     thumb_right_x);
	input_report_abs(xbox360->dev, ABS_RY,     thumb_right_y);

	input_sync(xbox360->dev);
}

#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,19)
static void xbox360_irq_in(struct urb *urb, struct pt_regs *regs)
#else
static void xbox360_irq_in(struct urb *urb)
#endif
{
	struct xbox360_device *xbox360 = urb->context;
	int retval;

	switch (urb->status) {
	case 0:
		/* success */
		break;
	case -ECONNRESET:
	case -ENOENT:
	case -ESHUTDOWN:
		/* this urb is terminated, clean up */
		dbg("%s - urb shutting down with status: %d", __FUNCTION__, urb->status);
		return;
	default:
		dbg("%s - nonzero urb status received: %d", __FUNCTION__, urb->status);
		goto exit;
	}

#if LINUX_VERSION_CODE < KERNEL_VERSION(2,6,19)
	xbox360_process_packet(xbox360, 0, xbox360->idata, regs);
#else
	xbox360_process_packet(xbox360, 0, xbox360->idata);
#endif

exit:
	retval = usb_submit_urb (urb, GFP_ATOMIC);
	if (retval) {
		err ("%s - usb_submit_urb failed with result %d", __FUNCTION__, retval);
	}
}

static int xbox360_open (struct input_dev *dev)
{
	struct xbox360_device *xbox360 = dev->private;

	xbox360->irq_in->dev = xbox360->udev;
	if (usb_submit_urb(xbox360->irq_in, GFP_KERNEL)) {
		return -EIO;
	}

	return 0;
}

static void xbox360_close (struct input_dev *dev)
{
	struct xbox360_device *xbox360 = dev->private;

	usb_kill_urb(xbox360->irq_in);
}

static int xbox360_probe(struct usb_interface *intf, const struct usb_device_id *id)
{
	struct xbox360_device *xbox360;
	struct xbox360_device_type *type = NULL;
	struct usb_device *udev = interface_to_usbdev(intf);
	struct usb_endpoint_descriptor *ep_irq_in;
	int i;

	/*
	 * Find Xbox 360 device type.
	 */
	for (i = 0; xbox360_device_types[i].idVendor; i++) {
		if ((le16_to_cpu(udev->descriptor.idVendor ) == xbox360_device_types[i].idVendor ) &&
		    (le16_to_cpu(udev->descriptor.idProduct) == xbox360_device_types[i].idProduct)) {
			type = &xbox360_device_types[i];
			break;
		}
	}

	/*
	 * Memory allocation.
	 */
	xbox360 = kzalloc(sizeof(struct xbox360_device), GFP_KERNEL);
	if (!xbox360) {
		goto fail;
	}

	xbox360->dev = input_allocate_device();
	if (!xbox360->dev) {
		goto fail;
	}

	xbox360->idata = usb_buffer_alloc(udev, XPAD_PKT_LEN, GFP_ATOMIC, &xbox360->idata_dma);
	if (!xbox360->idata) {
		goto fail;
	}

	xbox360->irq_in = usb_alloc_urb(0, GFP_KERNEL);
	if (!xbox360->irq_in) {
		goto fail;
	}

	xbox360->type = type;

	/*
	 * General initialization.
	 */
	xbox360->dpad_as_hat = 1;
	xbox360->dpad_as_button = 0;
	xbox360->trigger_as_trigger = 1;
	xbox360->trigger_as_button = 0;
	xbox360->led = 0;
	xbox360->rumble_big = 0;
	xbox360->rumble_small = 0;

	/*
	 * Input device initialization.
	 */
	usb_make_path(udev, xbox360->phys, sizeof(xbox360->phys));
	strlcat(xbox360->phys, "/input0", sizeof(xbox360->phys));

	xbox360->dev->name = xbox360->type->name;
	xbox360->dev->phys = xbox360->phys;
	usb_to_input_id(udev, &xbox360->dev->id);
	xbox360->dev->cdev.dev = &intf->dev;
	xbox360->dev->private = xbox360;
	xbox360->dev->open = xbox360_open;
	xbox360->dev->close = xbox360_close;

	xbox360->dev->evbit[0] = BIT(EV_KEY) | BIT(EV_ABS);

	for (i = 0; xbox360_btn[i] >= 0; i++) {
		set_bit(xbox360_btn[i], xbox360->dev->keybit);
	}

	for (i = 0; xbox360_abs[i] >= 0; i++) {

		signed short t = xbox360_abs[i];

		set_bit(t, xbox360->dev->absbit);

		switch (t) {
			case ABS_X:
			case ABS_Y:
			case ABS_RX:
			case ABS_RY:	/* the two thumbs */
				input_set_abs_params(xbox360->dev, t, THUMB_MIN, THUMB_MAX, THUMB_NOISE, THUMB_THRESHHOLD);
				break;
			case ABS_Z:
			case ABS_RZ:	/* the triggers */
				input_set_abs_params(xbox360->dev, t, TRIGGER_MIN, TRIGGER_MAX, TRIGGER_NOISE, TRIGGER_THRESHHOLD);
				break;
			case ABS_HAT0X:
			case ABS_HAT0Y:	/* the d-pad */
				input_set_abs_params(xbox360->dev, t, DPAD_MIN, DPAD_MAX, DPAD_NOISE, DPAD_THRESHHOLD);
				break;
		}
	}

	/*
	 * USB device initialization.
	 */
	xbox360->udev = udev;
	ep_irq_in = &intf->cur_altsetting->endpoint[0].desc;
	usb_fill_int_urb(xbox360->irq_in, udev,
			 usb_rcvintpipe(udev, ep_irq_in->bEndpointAddress),
			 xbox360->idata, XPAD_PKT_LEN, xbox360_irq_in,
			 xbox360, ep_irq_in->bInterval);
	xbox360->irq_in->transfer_dma = xbox360->idata_dma;
	xbox360->irq_in->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;

	input_register_device(xbox360->dev);

	usb_set_intfdata(intf, xbox360);

	/*
	 * Add sysfs entries.
	 */
	if (xbox360_sysfs_add(xbox360->dev)) {
		goto fail;
	}

	/*
         * Success.
         * Time to update effects.
         */
	xbox360_led_set(xbox360);
	xbox360_rumble_set(xbox360);

	return 0;

fail:
	if (xbox360) {
		if (xbox360->dev) {
			input_free_device(xbox360->dev);
		}
		if(xbox360->idata) {
			usb_buffer_free(udev, XPAD_PKT_LEN, xbox360->idata, xbox360->idata_dma);
		}
		kfree(xbox360);
	}
	return -ENOMEM;
}

static void xbox360_disconnect(struct usb_interface *intf)
{
	struct xbox360_device *xbox360 = usb_get_intfdata (intf);

	xbox360_sysfs_remove(xbox360->dev);

	usb_set_intfdata(intf, NULL);
	if (xbox360) {
		usb_kill_urb(xbox360->irq_in);
		input_unregister_device(xbox360->dev);
		usb_free_urb(xbox360->irq_in);
		usb_buffer_free(interface_to_usbdev(intf), XPAD_PKT_LEN, xbox360->idata, xbox360->idata_dma);
		kfree(xbox360);
	}
}

/*
 * sysfs.
 */
static ssize_t xbox360_show_rumble_big(struct class_device *cdev, char *buf)
{
	struct input_dev *dev = to_input_dev(cdev);
        struct xbox360_device *xbox360 = dev->private;

	return sprintf(buf, "%d\n", xbox360->rumble_big);
}
static ssize_t xbox360_store_rumble_big(struct class_device *cdev, const char *buf, size_t count)
{
	struct input_dev *dev = to_input_dev(cdev);
        struct xbox360_device *xbox360 = dev->private;
	int rumble_big;
	int ret;

        ret=sscanf(buf, "%d", &rumble_big);
	if (ret != 1)
		return -EINVAL;
	if (rumble_big < 0x00) 
		return -EINVAL;
	if (rumble_big > 0xff)
		return -EINVAL;

	xbox360->rumble_big = rumble_big;

	xbox360_rumble_set(xbox360);

        return count;
}
static CLASS_DEVICE_ATTR(rumble_big, 0664, xbox360_show_rumble_big, xbox360_store_rumble_big);

static ssize_t xbox360_show_rumble_small(struct class_device *cdev, char *buf)
{
	struct input_dev *dev = to_input_dev(cdev);
        struct xbox360_device *xbox360 = dev->private;

	return sprintf(buf, "%d\n", xbox360->rumble_small);
}
static ssize_t xbox360_store_rumble_small(struct class_device *cdev, const char *buf, size_t count)
{
	struct input_dev *dev = to_input_dev(cdev);
        struct xbox360_device *xbox360 = dev->private;
	int rumble_small;
	int ret;

        ret=sscanf(buf, "%d", &rumble_small);
	if (ret != 1)
		return -EINVAL;
	if (rumble_small < 0x00) 
		return -EINVAL;
	if (rumble_small > 0xff)
		return -EINVAL;

	xbox360->rumble_small = (unsigned char)rumble_small;

	xbox360_rumble_set(xbox360);

        return count;
}
static CLASS_DEVICE_ATTR(rumble_small, 0664, xbox360_show_rumble_small, xbox360_store_rumble_small);

static ssize_t xbox360_show_led(struct class_device *cdev, char *buf)
{
	struct input_dev *dev = to_input_dev(cdev);
        struct xbox360_device *xbox360 = dev->private;

	return sprintf(buf, "%d\n", xbox360->led);
}
static ssize_t xbox360_store_led(struct class_device *cdev, const char *buf, size_t count)
{
	struct input_dev *dev = to_input_dev(cdev);
        struct xbox360_device *xbox360 = dev->private;
	int led;
	int ret;

        ret=sscanf(buf, "%d", &led);
	if (ret != 1)
		return -EINVAL;
	if (led < 0x00) 
		return -EINVAL;
	if (led > 0x0f)
		return -EINVAL;

	xbox360->led = (unsigned char)led;

	xbox360_led_set(xbox360);

        return count;
}
static CLASS_DEVICE_ATTR(led, 0664, xbox360_show_led, xbox360_store_led);

static struct attribute *xbox360_attributes[] = {
	&class_device_attr_rumble_big.attr,
	&class_device_attr_rumble_small.attr,
	&class_device_attr_led.attr,
	NULL,
};

static struct attribute_group input_dev_controls_attr_group = {
        .name   = "controls",
        .attrs  = xbox360_attributes,
};
	
static int xbox360_sysfs_add(struct input_dev *dev)
{
	struct class_device *cdev = &dev->cdev;
/*
	struct attribute **attr;
 */
	int error = 0;

        error = sysfs_create_group(&cdev->kobj, &input_dev_controls_attr_group);

	return error;
}

static void xbox360_sysfs_remove(struct input_dev *dev)
{
	struct class_device *cdev = &dev->cdev;

	sysfs_remove_group(&cdev->kobj, &input_dev_controls_attr_group);
}

/*
 *
 */
static struct usb_driver xbox360_driver = {
	.name		= "xbox360",
	.probe		= xbox360_probe,
	.disconnect	= xbox360_disconnect,
	.id_table	= xbox360_table,
};

static int __init xbox360_device_init(void)
{
	int result = usb_register(&xbox360_driver);
	if (result == 0) {
		info(DRIVER_DESC " version " DRIVER_VERSION);
	}
	return result;
}

static void __exit xbox360_device_exit(void)
{
	usb_deregister(&xbox360_driver);
}

module_init(xbox360_device_init);
module_exit(xbox360_device_exit);

MODULE_AUTHOR(DRIVER_AUTHOR);
MODULE_DESCRIPTION(DRIVER_DESC);
MODULE_LICENSE("GPL");
MODULE_VERSION(DRIVER_VERSION);
