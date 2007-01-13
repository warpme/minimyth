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

DEPENDS   = lang/c X11/X11 X11/freetype lib/libpng lirc/lirc myth/xine-lib
BUILDDEPS = devel/pkgconfig

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--cache-file=config.cache \
	--x-includes=$(DESTDIR)$(x11includedir) \
	--x-libraries=$(DESTDIR)$(x11libdir) \
	--with-gnu-ld \
	--with-xine-prefix=$(DESTDIR)$(prefix) \
	--with-xine-exec-prefix=$(DESTDIR)$(prefix) \
	--with-x \
	--without-readline \
	--with-aalib-prefix=$(DESTDIR)$(prefix) \
	--with-aalib-exec-prefix=$(DESTDIR)$(prefix)
CONFIGURE_ENV  = \
	PKG_CONFIG_PATH="$(DESTDIR)$(libdir)/pkgconfig:$(DESTDIR)$(x11libdir)/pkgconfig:$(DESTDIR)$(qtlibdir)/pkgconfig"

include ../../gar.mk

CFLAGS := $(CFLAGS) -Wl,-rpath-link,$(DESTDIR)$(x11libdir)

pre-configure:
	@echo "ac_cv_path_CURL_CONFIG=no"  >  $(WORKSRC)/config.cache
	@echo "ac_cv_path_AALIB_CONFIG=no" >> $(WORKSRC)/config.cache
	@echo "ac_cv_path_CACA_CONFIG=no"  >> $(WORKSRC)/config.cache
	@$(MAKECOOKIE)
