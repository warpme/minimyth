GARNAME = xorg
GARVERSION = new
CATEGORIES = xorg-new
LICENSE =

DESCRIPTION = 
define BLURB
endef

DEPENDS = \
	xorg-new/xorg-server \
	xorg-new/xf86-input-keyboard \
	xorg-new/xf86-input-mouse \
	xorg-new/xf86-video-i810 \
	xorg-new/xf86-video-openchrome \
	xorg-new/font-alias \
	xorg-new/font-bh-ttf \
	xorg-new/font-misc-misc \
	xorg-new/font-cursor-misc \
	xorg-new/rgb \
	xorg-new/xdpyinfo \
	xorg-new/xinit \
	xorg-new/xset \
	xorg-new/xsetroot \
	xorg-new/libXaw \
	xorg-new/libXdamage \
	xorg-new/libXfixes \
	xorg-new/libXinerama \
	xorg-new/libXrandr \
	xorg-new/libXtst \
	xorg-new/libXxf86dga \
	xorg-new/libXres

include ../../gar.mk

post-install:
	@rm -rf $(DESTDIR)$(versiondir)/$(GARNAME)
	@rm -rf $(DESTDIR)$(licensedir)/$(GARNAME)
	@$(MAKECOOKIE)
