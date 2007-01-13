GARNAME = recordproto
GARVERSION = X11R$(XORG_VERSION)-1.13.2
CATEGORIES = xorg-7.0
MASTER_SITES = http://xorg.freedesktop.org/releases/X11R$(XORG_VERSION)/src/proto/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/COPYING

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST)

GAR_EXTRA_CONF += xorg-7.0/xorg/package-api.mk
include ../../gar.mk

CFLAGS   := $(patsubst -O%,,$(CFLAGS)  ) -O2
CXXFLAGS := $(patsubst -O%,,$(CXXFLAGS)) -O2

post-install:
	@sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'         $(DESTDIR)$(libdir)/pkgconfig/$(GARNAME).pc
	@sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g' $(DESTDIR)$(libdir)/pkgconfig/$(GARNAME).pc
	@$(MAKECOOKIE)
