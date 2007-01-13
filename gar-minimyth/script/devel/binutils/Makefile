GARNAME = binutils
GARVERSION = 2.16.1
CATEGORIES = devel
MASTER_SITES  = ftp://ftp.gnu.org/gnu/$(GARNAME)/
MASTER_SITES += ftp://ftp.kernel.org/pub/linux/devel/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = GPL2/LGPL2

DESCRIPTION =
define BLURB
endef

CROSSIMG ?= $(DESTIMG)
GARTARGET = $($(CROSSIMG)_GARHOST)

DEPENDS = lang/c

WORKDIR   = $(WORKROOTDIR)/$(DESTIMG)_$(CROSSIMG).d
COOKIEDIR = $(COOKIEROOTDIR)/$(DESTIMG)_$(CROSSIMG).d

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) --target=$(GARTARGET) \
	--enable-shared \
	--with-lib-path=$(LIB_PATH)

GAR_EXTRA_CONF += devel/gcc/package-api.mk
include ../../gar.mk

LIB_PATH := $($(CROSSIMG)_DESTDIR)$($(CROSSIMG)_elibdir):$($(CROSSIMG)_DESTDIR)$($(CROSSIMG)_libdir):$($(CROSSIMG)_DESTDIR)$($(CROSSIMG)_x11libdir):$($(CROSSIMG)_DESTDIR)$($(CROSSIMG)_qtlibdir):$(CROSS_GCC_LIBDIR):$(LIBDIR):$(CROSS_GCC_LIBDIR)
# For the native environment, glibc is not installed, so the native environment needs to pick up glibc from the system.
ifeq ("$(DESTIMG)+$(CROSSIMG)","build+build")
LIB_PATH := $(LIB_PATH):/lib:/usr/lib
endif

post-install:
	@rm -f $(DESTDIR)$(libdir)/libbfd.la
	@rm -f $(DESTDIR)$(libdir)/libopcodes.la
	@$(if $(filter $(GARHOST), $(GARTARGET)),, rm -f $(DESTDIR)$(prefix)/$(GARHOST)/$(GARTARGET)/lib/libbfd.la)
	@$(if $(filter $(GARHOST), $(GARTARGET)),, rm -f $(DESTDIR)$(prefix)/$(GARHOST)/$(GARTARGET)/lib/libopcodes.la)
	@rm -f $(DESTDIR)$(libdir)/libopcodes.la
	@$(MAKECOOKIE)
