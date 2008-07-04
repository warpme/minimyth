GARNAME = gcc
GARVERSION = $(GCC_VERSION)
CATEGORIES = devel
MASTER_SITES  = ftp://ftp.gnu.org/gnu/$(GARNAME)/$(DISTNAME)/
MASTER_SITES += ftp://ftp.gnu.org/gnu/$(GARNAME)/releases/$(DISTNAME)/
MASTER_SITES += ftp://gcc.gnu.org/pub/$(GARNAME)/releases/$(DISTNAME)/
MASTER_SITES += ftp://gcc.gnu.org/pub/$(GARNAME)/prerelease-$(GCC_VERSION)/
MASTER_SITES += ftp://gcc.gnu.org/pub/$(GARNAME)/snapshots/$(GCC_VERSION)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES  = $(DISTNAME)-disable_multilib_i386_linux64.patch
ifneq ("$(DESTIMG)+$(CROSSIMG)","build+build")
PATCHFILES += $(DISTNAME)-perl.patch.gar
PATCHFILES += $(DISTNAME)-dynamic_linker.patch
PATCHFILES += $(DISTNAME)-libstdc++-v3_config.patch
endif
LICENSE = GPL2/LGPL2_1

DESCRIPTION =
define BLURB
endef

CROSSIMG ?= $(DESTIMG)
GARTARGET = $($(CROSSIMG)_GARHOST)

IMGDEPS += $(CROSSIMG)
$(CROSSIMG)_DEPENDS = devel/glibc
DEPENDS  = lang/c lib/gmp lib/mpfr
BUILDDEPS = devel/make devel/binutils

WORKDIR   = $(WORKROOTDIR)/$(DESTIMG)_$(CROSSIMG).d
COOKIEDIR = $(COOKIEROOTDIR)/$(DESTIMG)_$(CROSSIMG).d

WORKBLD = $(WORKSRC)_build

CONFIGURE_SCRIPTS = custom
BUILD_SCRIPTS     = $(WORKBLD)/Makefile
INSTALL_SCRIPTS   = $(WORKBLD)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) --target=$(GARTARGET) \
	--with-gnu-as \
	--with-gnu-ld \
	--with-local-prefix=$(patsubst %/include,%,$($(CROSSIMG)_includedir)) \
	--enable-__cxa_atexit \
	--enable-clocale=gnu \
	--enable-languages=c,c++ \
	--enable-libgomp \
	--disable-libmudflap \
	--disable-multilib \
	--enable-nls \
	--enable-shared \
	--enable-threads=posix \
	--enable-version-specific-runtime-libs \
	--with-mpfr-include=$(DESTDIR)$(includedir) \
	--with-mpfr-lib=$(DESTDIR)$(libdir) \
	--with-gmp-include=$(DESTDIR)$(includedir) \
	--with-gmp-lib=$(DESTDIR)$(libdir) \
	--with-sysroot=$($(CROSSIMG)_DESTDIR)
# Bootstrap the native environment compiler.
ifeq ("$(DESTIMG)+$(CROSSIMG)","build+build")
BUILD_ARGS     = \
	bootstrap
endif

GAR_EXTRA_CONF += devel/glibc/package-api.mk
include ../../gar.mk

CPPFLAGS :=
CFLAGS   :=
CXXFLAGS :=
LDFLAGS  :=

configure-custom:
	@mkdir -p $(WORKBLD)
	@cd $(WORKBLD) && $(CONFIGURE_ENV) ./$(call DIRSTODOTS,$(WORKBLD))/$(WORKSRC)/configure $(CONFIGURE_ARGS)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(CROSS_GCC_LIBDIR)/libgomp.la
	@rm -f $(CROSS_GCC_LIBDIR)/libssp.la
	@rm -f $(CROSS_GCC_LIBDIR)/libssp_nonshared.la
	@rm -f $(CROSS_GCC_LIBDIR)/libstdc++.la
	@rm -f $(CROSS_GCC_LIBDIR)/libsupc++.la
	@# Native compile.
	@$(if $(filter     $(DESTIMG),$(CROSSIMG)), \
		ln -sf gcc $(DESTDIR)$(bindir)/cc ; \
	)
	@# Cross compile.
	@$(if $(filter-out $(DESTIMG),$(CROSSIMG)), \
		mkdir -p $(DESTDIR)$(prefix)/$(GARHOST)/bin ; \
		cp $(DESTDIR)$(bindir)/$(GARTARGET)-cpp $(DESTDIR)$(prefix)/$(GARTARGET)/bin/cpp ; \
		cp $(DESTDIR)$(bindir)/$(GARTARGET)-gcc $(DESTDIR)$(prefix)/$(GARTARGET)/bin/cc ; \
	)
	@$(MAKECOOKIE)
