GARNAME = xdpyinfo
GARVERSION = X11R$(XORG_VERSION)-1.0.1
CATEGORIES = xorg-new
MASTER_SITES = http://xorg.freedesktop.org/releases/X11R$(XORG_VERSION)/src/app/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/COPYING

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c xorg-new/libXext xorg-new/libX11 xorg-new/libXi xorg-new/libXinerama xorg-new/libXrender xorg-new/libXtst xorg-new/libXxf86dga xorg-new/libXxf86misc xorg-new/libXxf86vm

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST)

GAR_EXTRA_CONF += xorg-new/xorg/package-api.mk
include ../../gar.mk
