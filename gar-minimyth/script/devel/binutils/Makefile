GARNAME = binutils
GARVERSION = 2.15.94.0.2
CATEGORIES = devel
MASTER_SITES  = ftp://ftp.gnu.org/pub/gnu/binutils/
MASTER_SITES += ftp://ftp.kernel.org/pub/linux/devel/binutils/
DISTFILES = $(GARNAME)-$(GARVERSION).tar.bz2
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
	--with-lib-path=$($(CROSSIMG)_DESTDIR)$($(CROSSIMG)_elibdir):$($(CROSSIMG)_DESTDIR)$($(CROSSIMG)_libdir):$(CROSS_GCC_LIBDIR)

GAR_EXTRA_CONF += devel/gcc/package-api.mk
include ../../gar.mk

post-install:
	@rm -f $(DESTDIR)$(libdir)/libbfd.la
	@rm -f $(DESTDIR)$(libdir)/libopcodes.la
	@$(if $(filter $(GARHOST), $(GARTARGET)),, rm -f $(DESTDIR)$(prefix)/$(GARHOST)/$(GARTARGET)/lib/libbfd.la)
	@$(if $(filter $(GARHOST), $(GARTARGET)),, rm -f $(DESTDIR)$(prefix)/$(GARHOST)/$(GARTARGET)/lib/libopcodes.la)
	@rm -f $(DESTDIR)$(libdir)/libopcodes.la
	@$(MAKECOOKIE)
