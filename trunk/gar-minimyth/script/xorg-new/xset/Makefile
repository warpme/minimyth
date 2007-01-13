GARNAME = xset
GARVERSION = X11R$(XORG_VERSION)-1.0.1
CATEGORIES = xorg-new
MASTER_SITES = http://xorg.freedesktop.org/releases/X11R$(XORG_VERSION)/src/app/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/COPYING

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c xorg-new/libXmu xorg-new/xextproto xorg-new/libXext xorg-new/kbproto xorg-new/libX11 xorg-new/xf86miscproto xorg-new/libXxf86misc

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST)

GAR_EXTRA_CONF += xorg-new/xorg/package-api.mk
include ../../gar.mk
