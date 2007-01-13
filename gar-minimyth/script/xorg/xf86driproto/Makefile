GARNAME = xf86driproto
GARVERSION = 2.0.3
CATEGORIES = xorg
MASTER_SITES = http://xorg.freedesktop.org/releases/X11R$(XORG_VERSION)/src/proto/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE =

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST)

GAR_EXTRA_CONF += xorg/xorg/package-api.mk
include ../../gar.mk
include ../xorg.mk

post-install:
	@sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'         $(DESTDIR)$(x11libdir)/pkgconfig/$(GARNAME).pc
	@sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g' $(DESTDIR)$(x11libdir)/pkgconfig/$(GARNAME).pc
	@$(MAKECOOKIE)
