#!/bin/sh

. /etc/conf

/usr/bin/xsetroot -solid black
/usr/bin/xset -dpms
if /usr/bin/test "${MM_X_SCREENSAVER_ENABLED}" = "yes" ; then
    /usr/bin/xset s on
    /usr/bin/xset s 120
else
    /usr/bin/xset s off
fi
if /usr/bin/test "${MM_X_VNC_ENABLED}" = "yes" ; then
    /usr/bin/x11vnc
fi
if /usr/bin/test "${MM_X_WM_ENABLED}" = "yes" ; then
    /usr/bin/ratpoison &
fi
if /usr/bin/test -z "${MM_DEBUG}" ; then
    /usr/bin/mythfrontend
else
    /usr/bin/mythfrontend -v all
fi
