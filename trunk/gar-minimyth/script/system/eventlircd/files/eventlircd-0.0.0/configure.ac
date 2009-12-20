dnl Copyright (C) 2009 Paul Bender.
dnl
dnl This file is part of eventlircd.
dnl
dnl eventlircd is free software: you can redistribute it and/or modify
dnl it under the terms of the GNU General Public License as published by
dnl the Free Software Foundation, either version 2 of the License, or
dnl (at your option) any later version.
dnl
dnl eventlircd is distributed in the hope that it will be useful,
dnl but WITHOUT ANY WARRANTY; without even the implied warranty of
dnl MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
dnl GNU General Public License for more details.
dnl
dnl You should have received a copy of the GNU General Public License
dnl along with eventlircd.  If not, see <http://www.gnu.org/licenses/>.

AC_INIT([eventlircd], [0.0.0])

AC_PREREQ([2.63])

AC_CONFIG_SRCDIR([src/main.c])
AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_MACRO_DIR([m4])

AM_INIT_AUTOMAKE([gnu dist-bzip2])

AC_PREFIX_DEFAULT([/usr])

AM_SILENT_RULES

AC_PROG_CC
AC_PROG_CC_C99

if test "x$ac_cv_prog_cc_c99" = "xno" ; then
    AC_MSG_ERROR([the compiler is not C99 compliant])
fi

AM_PROG_CC_C_O
AC_PROG_AWK
AC_PROG_GREP
AC_PROG_SED
AC_PROG_INSTALL

PKG_PROG_PKG_CONFIG

AC_HEADER_STDC
AC_HEADER_STDBOOL
AC_HEADER_TIME

AC_CHECK_HEADER([errno.h],[],[AC_MSG_ERROR([failed to find the required header file errno.h])])
AC_CHECK_HEADER([fcntl.h],[],[AC_MSG_ERROR([failed to find the required header file fcntl.h])])
AC_CHECK_HEADER([getopt.h],[],[AC_MSG_ERROR([failed to find the required header file getopt.h])])
AC_CHECK_HEADER([malloc.h],[],[AC_MSG_ERROR([failed to find the required header file malloc.h])])
AC_CHECK_HEADER([signal.h],[],[AC_MSG_ERROR([failed to find the required header file signal.h])])
AC_CHECK_HEADER([stdbool.h],[],[AC_MSG_ERROR([failed to find the required header file stdbool.h])])
AC_CHECK_HEADER([stddef.h],[],[AC_MSG_ERROR([failed to find the required header file stddef.h])])
AC_CHECK_HEADER([stdio.h],[],[AC_MSG_ERROR([failed to find the required header file stdio.h])])
AC_CHECK_HEADER([stdlib.h],[],[AC_MSG_ERROR([failed to find the required header file stdlib.h])])
AC_CHECK_HEADER([string.h],[],[AC_MSG_ERROR([failed to find the required header file string.h])])
AC_CHECK_HEADER([sysexits.h],[],[AC_MSG_ERROR([failed to find the required header file sysexits.h])])
AC_CHECK_HEADER([syslog.h],[],[AC_MSG_ERROR([failed to find the required header file syslog.h])])
AC_CHECK_HEADER([unistd.h],[],[AC_MSG_ERROR([failed to find the required header file unistd.h])])

AC_CHECK_HEADER([sys/select.h],[],[AC_MSG_ERROR([failed to find the required header file sys/select.h])])
AC_CHECK_HEADER([sys/socket.h],[],[AC_MSG_ERROR([failed to find the required header file sys/socket.h])])
AC_CHECK_HEADER([sys/stat.h],[],[AC_MSG_ERROR([failed to find the required header file sys/stat.h])])
AC_CHECK_HEADER([sys/time.h],[],[AC_MSG_ERROR([failed to find the required header file sys/time.h])])
AC_CHECK_HEADER([sys/types.h],[],[AC_MSG_ERROR([failed to find the required header file sys/types.h])])
AC_CHECK_HEADER([sys/un.h],[],[AC_MSG_ERROR([failed to find the required header file sys/un.h])])

AC_CHECK_HEADER([linux/input.h],[],[AC_MSG_ERROR([failed to find the required header file linux/input.h])])
AC_CHECK_HEADER([linux/limits.h],[],[AC_MSG_ERROR([failed to find the required header file linux/limits.h])])
AC_CHECK_HEADER([linux/types.h],[],[AC_MSG_ERROR([failed to find the required header file linux/types.h])])
AC_CHECK_HEADER([linux/uinput.h],[],[AC_MSG_ERROR([failed to find the required header file linux/uinput.h])])

AC_CHECK_HEADER([libudev.h],[],[AC_MSG_ERROR([failed to find the required header file libudev.h])])

dnl Determine the absolute path to the header file linux/input.h.
AX_ABSOLUTE_HEADER(linux/input.h)
if test "x$gl_cv_absolute_linux_input_h" = "x" ; then
    AC_MSG_ERROR([failed to find the absolute path to header file linux/input.h])
fi
AC_SUBST(ABSOLUTE_LINUX_INPUT_H, $gl_cv_absolute_linux_input_h)

PKG_CHECK_MODULES(LIBUDEV, [libudev >= 136])

AC_ARG_WITH(lircd-socket, AS_HELP_STRING([--with-lircd-socket=SOCKET], [lircd socket @<:@LOCALSTATEDIR/run/lirc/lircd@:>@]),
    [LIRCD_SOCKET="$withval"],
    [LIRCD_SOCKET="${localstatedir}/run/lirc/lircd"])
AC_SUBST(LIRCD_SOCKET)

AC_ARG_WITH(keymap-dir, AS_HELP_STRING([--with-keymap-dir=DIR], [key map directory @<:@SYSCONFDIR/eventlircd.d@:>@]),
    [KEYMAP_DIR="$withval"],
    [KEYMAP_DIR="${sysconfdir}/eventlircd.d"])
AC_SUBST(KEYMAP_DIR)

AC_ARG_WITH(udev-dir, AS_HELP_STRING([--with-udev-dir=DIR], [key map directory @<:@/lib/udev@:>@]),
    [UDEV_DIR="$withval"],
    [UDEV_DIR="/lib/udev"])
AC_SUBST(UDEV_DIR)

AC_CONFIG_HEADERS([src/config.h])
AC_CONFIG_FILES([Makefile etc/Makefile man/Makefile man/eventlircd.8 man/eventlircd.keymap.5 src/Makefile src/evkey_code_to_name.h.sh src/evkey_name_to_code.h.sh src/evkey_type.h.sh udev/Makefile udev/lircd_helper udev/wakeup_enable udev/rules.d/98-lircd.rules.disabled udev/rules.d/98-eventlircd.rules.disabled])
AC_OUTPUT
