GARNAME = libXrender
GARVERSION = X11R$(XORG_VERSION)-0.9.0.2
CATEGORIES = xorg-7.0
MASTER_SITES = http://xorg.freedesktop.org/releases/X11R$(XORG_VERSION)/src/lib/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/COPYING

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c xorg-7.0/libX11 xorg-7.0/renderproto

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-malloc0returnsnull \
	--with-gnu-ld

GAR_EXTRA_CONF += xorg-7.0/xorg/package-api.mk
include ../../gar.mk

CFLAGS   := $(patsubst -O%,,$(CFLAGS)  ) -O2
CXXFLAGS := $(patsubst -O%,,$(CXXFLAGS)) -O2

post-install:
	@rm -f $(DESTDIR)$(libdir)/$(GARNAME).la
	@sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'         $(DESTDIR)$(libdir)/pkgconfig/xrender.pc
	@sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g' $(DESTDIR)$(libdir)/pkgconfig/xrender.pc
	@$(MAKECOOKIE)
