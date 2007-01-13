GARNAME = xorg
GARVERSION = $(XORG_VERSION)
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

GAR_EXTRA_CONF += xorg-mid/xorg/package-api.mk
include ../../gar.mk
