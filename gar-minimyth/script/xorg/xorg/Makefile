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
	xorg/xf86-video-i810 \
	xorg/xf86-video-openchrome \
	xorg/font-alias \
	xorg/font-bh-ttf \
	xorg/font-misc-misc \
	xorg/font-cursor-misc \
	xorg/rgb \
	xorg/xdpyinfo \
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

GAR_EXTRA_CONF += xorg/xorg/package-api.mk
include ../../gar.mk
