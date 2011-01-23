GARNAME = libusb-compat
GARVERSION = 0.1.3
CATEGORIES = lib
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/libusb/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME).patch.gar
LICENSE = LGPL2_1

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/libusb

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-shared \
	--disable-static \
	--disable-log \
	--disable-debug-log \
	--disable-examples-build \
	--with-gnu-ld

include ../../gar.mk

pre-configure:
	@$(call RUN_AUTOTOOLS)
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libusb.la
	@rm -f $(DESTDIR)$(bindir)-config/libusb-config
	@rm -f $(DESTDIR)$(bindir)-config/$(compiler_prefix)libusb-config
	@mkdir -p $(DESTDIR)$(bindir)-config
	@mv $(DESTDIR)$(bindir)/libusb-config $(DESTDIR)$(bindir)-config/libusb-config
	@$(if $(compiler_prefix), ln -s libusb-config $(DESTDIR)$(bindir)-config/$(compiler_prefix)libusb-config)
	@$(MAKECOOKIE)