GARNAME = binutils
GARVERSION = $(BINUTILS_VERSION)
CATEGORIES = devel-tainted
SOURCEPKG = devel/binutils
LICENSE = GPL2/LGPL2

DESCRIPTION =
define BLURB
endef

CROSSIMG ?= $(DESTIMG)
GARTARGET = $($(CROSSIMG)_GARHOST)

ifneq ("$(DESTIMG)+$(CROSSIMG)","build+build")
endif

DEPENDS   = devel-tainted/gmp devel-tainted/mpfr
BUILDDEPS = devel-tainted/make

WORKDIR   = $(WORKROOTDIR)/$(DESTIMG)_$(CROSSIMG).d
COOKIEDIR = $(COOKIEROOTDIR)/$(DESTIMG)_$(CROSSIMG).d

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS  = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) --target=$(GARTARGET) \
	--disable-werror \
	--disable-nls \
	--disable-multilib \
	--with-mpfr-include=$(DESTDIR)$(includedir) \
	--with-mpfr-lib=$(DESTDIR)$(libdir) \
	--with-gmp-include=$(DESTDIR)$(includedir) \
	--with-gmp-lib=$(DESTDIR)$(libdir) \
	--with-sysroot=$($(CROSSIMG)_DESTDIR) \
	--with-lib-path="=$($(CROSSIMG)_elibdir):=$($(CROSSIMG)_libdir):$(strip $(if $(filter i386,$(GARCH_FAMILY)),:/lib32:/usr/lib32:/lib:/usr/lib) $(if $(filter x86_64,$(GARCH_FAMILY)),:/lib64:/usr/lib64:/lib:/usr/lib))"

GAR_EXTRA_CONF += devel/binutils/package-api.mk
include ../../gar.mk

CPPFLAGS :=
CFLAGS   :=
CXXFLAGS :=
LDFLAGS  :=

post-install:
	rm -f $(DESTDIR)$(libdir)/libbfd.la
	rm -f $(DESTDIR)$(prefix)/$(GARHOST)/$(GARTARGET)/lib/libbfd.la
	rm -f $(DESTDIR)$(libdir)/libopcodes.la
	rm -f $(DESTDIR)$(prefix)/$(GARHOST)/$(GARTARGET)/lib/libopcodes.la
	@$(MAKECOOKIE)
