GARNAME = libusb
GARVERSION = 0.1.8
CATEGORIES = lib
MASTER_SITES = http://unc.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-DESTDIR.patch
LICENSE = LGPL2_1

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-debug \
	--disable-build-docs \
	--with-gnu-ld

include ../../gar.mk

pre-configure:
	@cd $(WORKSRC) ; aclocal
	@cd $(WORKSRC) ; libtoolize --copy --force
	@cd $(WORKSRC) ; autoconf
	$(MAKECOOKIE)

post-install:
	rm -f $(DESTDIR)$(libdir)/libusb.la
	$(MAKECOOKIE)
