GARNAME = xorg
GARVERSION = $(XORG_VERSION)
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

GAR_EXTRA_CONF += xorg-old/xorg/package-api.mk
include ../../gar.mk
