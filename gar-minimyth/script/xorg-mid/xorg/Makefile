GARNAME = xorg
GARVERSION = mid
CATEGORIES = xorg-mid
LICENSE =

DESCRIPTION = 
define BLURB
endef

DEPENDS = \
	xorg-mid/X11 \
	xorg-mid/Mesa \
	xorg-mid/libXvMCW \
	xorg-mid/xf86-video-openchrome

include ../../gar.mk

post-install:
	@rm -rf $(DESTDIR)$(versiondir)/$(GARNAME)
	@rm -rf $(DESTDIR)$(licensedir)/$(GARNAME)
	@$(MAKECOOKIE)
