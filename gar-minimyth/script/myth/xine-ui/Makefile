GARNAME = xine-ui
GARVERSION = 0.99.3
CATEGORIES = myth
MASTER_SITES = http://unc.dl.sourceforge.net/sourceforge/xine/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME).patch.gar
LICENSE = 

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c X11/X11 X11/freetype lib/libpng lirc/lirc myth/xine-lib

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ENV = \
	PKG_CONFIG_PATH="$(DESTDIR)$(libdir)/pkgconfig:$(DESTDIR)$(x11libdir)/pkgconfig:$(DESTDIR)$(qtlibdir)/pkgconfig"

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes=$(DESTDIR)$(x11includedir) \
	--x-libraries=$(DESTDIR)$(x11libdir) \
	--with-gnu-ld \
	--with-xine-prefix=$(DESTDIR)$(prefix) \
	--with-x \
	--without-curl \
	--without-aalib \
	--without-caca \
	--with-png-prefix=$(DESTDIR)$(prefix)

include ../../gar.mk

CFLAGS := $(CFLAGS) -Wl,-rpath-link,$(DESTDIR)$(x11libdir)
