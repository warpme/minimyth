GARNAME = libXft
GARVERSION = X11R$(XORG_VERSION)-2.1.8.2
CATEGORIES = xorg-7.0
MASTER_SITES = http://xorg.freedesktop.org/releases/X11R$(XORG_VERSION)/src/lib/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME).patch.gar
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/COPYING

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/fontconfig lib/freetype xorg-7.0/libXrender

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--with-gnu-ld

GAR_EXTRA_CONF += xorg-7.0/xorg/package-api.mk
include ../../gar.mk

CFLAGS   := $(patsubst -O%,,$(CFLAGS)  ) -O2
CXXFLAGS := $(patsubst -O%,,$(CXXFLAGS)) -O2

post-install:
	@rm -f $(DESTDIR)$(libdir)/$(GARNAME).la
	@sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'         $(DESTDIR)$(libdir)/pkgconfig/xft.pc
	@sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g' $(DESTDIR)$(libdir)/pkgconfig/xft.pc
	@$(MAKECOOKIE)
