XORG_VERSION      = 7.0
XORG_MASTER_SITES = \
	$(foreach                                                           \
		dir,                                                        \
		app data doc driver            font lib proto util xserver, \
	        http://xorg.freedesktop.org/releases/individual/$(dir)/     \
	) \
	$(foreach                                                           \
		dir,                                                        \
		app data doc driver exerything font lib proto util xserver, \
		http://xorg.freedesktop.org/releases/X11R7.0/src/$(dir)/    \
	)
