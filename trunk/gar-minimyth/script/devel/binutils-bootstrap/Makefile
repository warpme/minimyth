GARNAME = binutils-bootstrap
GARVERSION = $(BINUTILS_VERSION)
CATEGORIES = devel
SOURCEPKG = devel/binutils
LICENSE = GPL2/LGPL2

DESCRIPTION = 
define BLURB
endef

BUILDDEPS = devel/make-bootstrap

WORKSRC = $(WORKDIR)/binutils-$(GARVERSION)

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = static
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) --target=$(GARTARGET) \
	--disable-nls \
	--with-lib-path=$(DESTDIR)$(elibdir):$(DESTDIR)$(libdir):$(CROSS_GCC_LIBDIR):/lib:/usr/lib

GAR_EXTRA_CONF += devel/binutils/package-api.mk devel/gcc/package-api.mk
include ../../gar.mk

CONFIGURE_ENV := DESTDIR="$(DESTDIR)" CC=cc
BUILD_ENV     := DESTDIR="$(DESTDIR)" CC=cc
INSTALL_ENV   := DESTDIR="$(DESTDIR)" CC=cc

build-static:
	@$(MAKE) -C $(WORKSRC) configure-host
	@$(MAKE) -C $(WORKSRC) LDFLAGS="-all-static"
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libbfd.la
	@rm -f $(DESTDIR)$(libdir)/libopcodes.la
	@$(if $(filter $(GARHOST), $(GARTARGET)),, rm -f $(DESTDIR)$(prefix)/$(GARHOST)/$(GARTARGET)/lib/libbfd.la)
	@$(if $(filter $(GARHOST), $(GARTARGET)),, rm -f $(DESTDIR)$(prefix)/$(GARHOST)/$(GARTARGET)/lib/libopcodes.la)
	@$(MAKECOOKIE)
