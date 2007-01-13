GARNAME = xorg
GARVERSION = $(XORG_VERSION)
CATEGORIES = xorg
LICENSE =

DESCRIPTION = 
define BLURB
endef

DEPENDS = \
	xorg/xorg-server \
	xorg/xf86-input-keyboard \
	xorg/xf86-input-mouse \
	xorg/xf86-video-openchrome \
	xorg/font-alias \
	xorg/font-bh-ttf \
	xorg/font-misc-misc \
	xorg/font-cursor-misc \
	xorg/rgb \
	xorg/xinit \
	xorg/xset \
	xorg/xsetroot \
	xorg/libXaw \
	xorg/libXdamage \
	xorg/libXfixes \
	xorg/libXinerama \
	xorg/libXrandr \
	xorg/libXtst \
	xorg/libXxf86dga \
	xorg/libXres

#	xorg/libXScrnSaver

#	xorg/libXxf86misc

GAR_EXTRA_CONF += xorg/xorg/package-api.mk
include ../../gar.mk
include ../xorg.mk

clean-all:
	@$(MAKE) -C ../ clean
	@rm -rf $(DESTDIR)$(x11prefix)
	@rm -rf $(DESTDIR)$(bindir)/X11
	@rm -rf $(DESTDIR)$(datadir)/X11
	@rm -rf $(DESTDIR)$(includedir)/X11
	@rm -rf $(DESTDIR)$(libdir)/X11
	@rm -rf $(DESTDIR)$(sysconfdir)/X11
