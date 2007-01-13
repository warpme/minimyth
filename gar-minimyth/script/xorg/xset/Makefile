GARNAME = xset
GARVERSION = 1.0.1
CATEGORIES = xorg
MASTER_SITES = http://xorg.freedesktop.org/releases/X11R$(XORG_VERSION)/src/app/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/COPYING

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c xorg/libXmu xorg/xextproto xorg/libXext xorg/kbproto xorg/libX11 xorg/xf86miscproto xorg/libXxf86misc

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST)

GAR_EXTRA_CONF += xorg/xorg/package-api.mk
include ../../gar.mk
