GARNAME = libftdi
GARVERSION = 0.14
CATEGORIES = lib
MASTER_SITES = http://www.intra2net.com/de/produkte/opensource/ftdi/TGZ/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME).patch.gar
LICENSE = LGPL2

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
	--with-gnu-ld

CONFIGURE_ENV = \
	ac_cv_path_HAVELIBUSB=$(DESTDIR)$(bindir)/libusb-config

include ../../gar.mk

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libftdi.la
	@$(MAKECOOKIE)
