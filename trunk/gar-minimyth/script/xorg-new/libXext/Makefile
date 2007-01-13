GARNAME = libXext
GARVERSION = 1.0.0
CATEGORIES = xorg-new
MASTER_SITES = http://xorg.freedesktop.org/releases/X11R$(XORG_VERSION)/src/lib/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/COPYING

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c xorg-new/xproto xorg-new/libX11 xorg-new/xextproto

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-malloc0returnsnull \
	--with-gnu-ld

GAR_EXTRA_CONF += xorg-new/xorg/package-api.mk
include ../../gar.mk

post-install:
	@rm -f $(DESTDIR)$(libdir)/$(GARNAME).la
	@sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'         $(DESTDIR)$(libdir)/pkgconfig/xext.pc
	@sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g' $(DESTDIR)$(libdir)/pkgconfig/xext.pc
	@$(MAKECOOKIE)
