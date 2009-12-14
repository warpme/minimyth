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
#ifndef _LIRCUDEVD_LIRCD_H_
#define _LIRCUDEVD_LIRCD_H_ 1

#include <sys/stat.h>

#include <linux/input.h>

int lircd_init(const char *path, mode_t mode, const char *release_suffix);
int lircd_exit();
int lircd_send(const struct input_event *event, const char *name, int repeat_count, const char *remote);

#endif
