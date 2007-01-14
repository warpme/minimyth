XORG_VERSION      = 7.0
XORG_MASTER_SITES = \
	$(foreach                                                                    \
		dir,                                                                 \
		app data doc driver exerything extras font lib proto util xserver,   \
		http://xorg.freedesktop.org/releases/X11R$(XORG_VERSION)/src/$(dir)/ \
	) \
