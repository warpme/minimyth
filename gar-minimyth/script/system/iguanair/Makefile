GARNAME = iguanaIR
GARVERSION = 0.99
CATEGORIES = system
MASTER_SITES = http://iguanaworks.net/downloads/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-libusb_config.patch $(DISTNAME)-ln.patch
LICENSE = GPL2/LGPL2_1

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/libusb lib/popt

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-python

CONFIGURE_ENV  = \
	LIBUSB_CONFIG=$(DESTDIR)$(bindir)/libusb-config
ifneq ($(DESTIMG),build)
CONFIGURE_ENV += \
	ac_cv_func_lstat_dereferences_slashed_symlink='yes' \
	ac_cv_func_malloc_0_nonnull='yes' \
	ac_cv_func_realloc_0_nonnull='yes'
endif
INSTALL_ENV    = \
	LIBDIR='lib' \
	RPM_OS='yes'

include ../../gar.mk

post-extract:
	@cd $(WORKSRC) ; make cleanest
	@$(MAKECOOKIE)

pre-configure:
	@cd $(WORKSRC)/autoconf ; aclocal --verbose --force
	@cd $(WORKSRC)/autoconf ; autoconf --verbose --force -o ../configure
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)
