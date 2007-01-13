xset -dpms s off
if [ -z "`mm_var_get MM_NO_VNC`" ] ; then
	x11vnc -many -q -bg
fi
if [ -z "`mm_var_get MM_NO_XWM`" ] ; then
	ratpoison &
fi
if [ -z "`mm_var_get MM_DEBUG`" ] ; then
	mythfrontend        >> "`mm_var_get MM_LOGFILE`" 2>&1
else
	mythfrontend -v all >> "`mm_var_get MM_LOGFILE`" 2>&1
fi
