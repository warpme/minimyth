xsetroot -solid black
xset -dpms s off
if [ "`mm_var_get MM_X_VNC_ENABLED`" = "yes" ] ; then
	x11vnc -xinerama -xrandr -forever -q -bg
fi
if [ "`mm_var_get MM_X_WM_ENABLED`" = "yes" ] ; then
	aewm &
fi
if [ -z "`mm_var_get MM_DEBUG`" ] ; then
	mythfrontend        >> "`mm_var_get MM_LOGFILE`" 2>&1
else
	mythfrontend -v all >> "`mm_var_get MM_LOGFILE`" 2>&1
fi
