. /etc/conf

xsetroot -solid black
xset -dpms s off
if [ "${MM_X_SCREENSAVER_ENABLED}" = "yes" ] ; then
	xscreensaver &
fi
if [ "${MM_X_VNC_ENABLED}" = "yes" ] ; then
	x11vnc
fi
if [ "${MM_X_WM_ENABLED}" = "yes" ] ; then
	ratpoison &
fi
if [ -z "${MM_DEBUG}" ] ; then
	mythfrontend
else
	mythfrontend -v all
fi
