XORG_VERSION      = 7.1
XORG_MASTER_SITES = \
	$(foreach                                                                  \
		dir,                                                               \
		app data doc driver exerything extras font lib proto util xserver, \
		http://xorg.freedesktop.org/releases/X11R7.1/src/$(dir)/           \
	) \
	$(foreach                                                                  \
		dir,                                                               \
		app data doc driver exerything extras font lib proto util xserver, \
		http://xorg.freedesktop.org/releases/X11R7.0/src/$(dir)/           \
	) \
	$(foreach                                                                  \
		dir,                                                               \
		app data doc driver exerything extras font lib proto util xserver, \
	        http://xorg.freedesktop.org/releases/individual/$(dir)/            \
	) \
