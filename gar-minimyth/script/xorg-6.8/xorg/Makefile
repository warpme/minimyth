GARNAME = xorg
GARVERSION = old
CATEGORIES = xorg-6.8
LICENSE =

DESCRIPTION = 
define BLURB
endef

DEPENDS = \
	xorg-6.8/X11 \
	xorg-6.8/Mesa \
	xorg-6.8/libXvMCW \
	xorg-6.8/unichrome

include ../../gar.mk

post-install:
	@rm -rf $(DESTDIR)$(versiondir)/$(GARNAME)
	@rm -rf $(DESTDIR)$(licensedir)/$(GARNAME)
	@$(MAKECOOKIE)
