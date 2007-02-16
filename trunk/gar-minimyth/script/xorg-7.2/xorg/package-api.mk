XORG_VERSION      = 7.2
XORG_MASTER_SITES = \
	$(foreach                                                           \
		dir,                                                        \
		app data doc driver everything font lib proto util xserver, \
	        http://xorg.freedesktop.org/releases/individual/$(dir)/     \
	) \
	$(foreach                                                           \
		dir,                                                        \
		app data doc driver everything font lib proto util xserver, \
	        http://xorg.freedesktop.org/releases/X11R7.2/src/$(dir)/    \
	) \
	http://xcb.freedesktop.org/dist/
