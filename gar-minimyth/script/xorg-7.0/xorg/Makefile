GARNAME = xorg
GARVERSION = new
CATEGORIES = xorg-7.0
LICENSE =

DESCRIPTION = 
define BLURB
endef

DEPENDS = \
	xorg-7.0/xorg-server \
	xorg-7.0/xf86-input-keyboard \
	xorg-7.0/xf86-input-mouse \
	xorg-7.0/xf86-video-i810 \
	xorg-7.0/xf86-video-openchrome \
	xorg-7.0/font-alias \
	xorg-7.0/font-bh-ttf \
	xorg-7.0/font-misc-misc \
	xorg-7.0/font-cursor-misc \
	xorg-7.0/rgb \
	xorg-7.0/xdpyinfo \
	xorg-7.0/xinit \
	xorg-7.0/xset \
	xorg-7.0/xsetroot \
	xorg-7.0/libXaw \
	xorg-7.0/libXdamage \
	xorg-7.0/libXfixes \
	xorg-7.0/libXinerama \
	xorg-7.0/libXrandr \
	xorg-7.0/libXtst \
	xorg-7.0/libXxf86dga \
	xorg-7.0/libXres

include ../../gar.mk

post-install:
	@rm -rf $(DESTDIR)$(versiondir)/$(GARNAME)
	@rm -rf $(DESTDIR)$(licensedir)/$(GARNAME)
	@$(MAKECOOKIE)
