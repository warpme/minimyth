GARNAME = xorg
GARVERSION = old
CATEGORIES = xorg-old
LICENSE =

DESCRIPTION = 
define BLURB
endef

DEPENDS = \
	xorg-old/X11 \
	xorg-old/Mesa \
	xorg-old/libXvMCW \
	xorg-old/unichrome

include ../../gar.mk

post-install:
	@rm -rf $(DESTDIR)$(versiondir)/$(GARNAME)
	@rm -rf $(DESTDIR)$(licensedir)/$(GARNAME)
	@$(MAKECOOKIE)
