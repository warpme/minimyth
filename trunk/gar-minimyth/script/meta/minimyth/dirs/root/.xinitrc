xset -dpms s off
if [ -z ${MM_NO_VNC} ] ; then
	x11vnc -many -q -bg
fi
if [ -z ${MM_NO_XWM} ] ; then
	fvwm2 -f /etc/fvwm2rc &
fi
if [ -z ${MM_DEBUG} ] ; then
	mythfrontend        >> ${MM_LOGFILE} 2>&1
else
	mythfrontend -v all >> ${MM_LOGFILE} 2>&1
fi
