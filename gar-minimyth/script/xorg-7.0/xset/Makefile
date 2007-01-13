GARNAME = xset
GARVERSION = X11R$(XORG_VERSION)-1.0.1
CATEGORIES = xorg-7.0
MASTER_SITES = http://xorg.freedesktop.org/releases/X11R$(XORG_VERSION)/src/app/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/COPYING

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c xorg-7.0/libXmu xorg-7.0/xextproto xorg-7.0/libXext xorg-7.0/kbproto xorg-7.0/libX11 xorg-7.0/xf86miscproto xorg-7.0/libXxf86misc

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST)

GAR_EXTRA_CONF += xorg-7.0/xorg/package-api.mk
include ../../gar.mk

CFLAGS   := $(patsubst -O%,,$(CFLAGS)  ) -O2
CXXFLAGS := $(patsubst -O%,,$(CXXFLAGS)) -O2
