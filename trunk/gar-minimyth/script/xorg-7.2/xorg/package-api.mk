XORG_VERSION      = 7.2-RC1
XORG_MASTER_SITES = \
	$(foreach                                                                  \
		dir,                                                               \
		app data doc driver exerything extras font lib proto util xserver, \
	        http://xorg.freedesktop.org/releases/development/X11R7.2/$(dir)/   \
	) \
	$(foreach                                                                  \
		dir,                                                               \
		app data doc driver exerything extras font lib proto util xserver, \
	        http://xorg.freedesktop.org/releases/development/X11R7.1/$(dir)/   \
	) \
	$(foreach                                                                  \
		dir,                                                               \
		app data doc driver exerything extras font lib proto util xserver, \
	        http://xorg.freedesktop.org/releases/development/X11R7.0/$(dir)/   \
	) \
	$(foreach                                                                  \
		dir,                                                               \
		app data doc driver exerything extras font lib proto util xserver, \
	        http://xorg.freedesktop.org/releases/individual/$(dir)/            \
	) \
	http://xcb.freedesktop.org/dist/
