################################################################################
# x.mk
################################################################################

MM_TV = $(shell mm_var_get MM_TV)

TV = $(if $(MM_TV),$(MM_TV),"NTSC")

x: /root/.xinitrc /etc/X11/xorg.conf
	touch x

/root/.xinitrc: mm_conf_get network /root
	mm_conf_get /xinitrc /root/.xinitrc
	touch /root/.xinitrc

/etc/X11/xorg.conf: mm_var_get mm_conf_get /etc/X11
	mm_conf_get /xorg.conf /etc/X11/xorg.conf
	sed -i "s%@MM_TV@%$(TV)%" /etc/X11/xorg.conf
	touch /etc/X11/xorg.conf

/etc/X11: /etc
	mkdir -p /etc/X11
	touch /etc/X11
