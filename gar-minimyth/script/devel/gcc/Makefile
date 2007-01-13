GARNAME = gcc
GARVERSION = $(GCC_VERSION)
CATEGORIES = devel
MASTER_SITES  = ftp://ftp.gnu.org/gnu/$(GARNAME)/$(DISTNAME)/
MASTER_SITES += ftp://ftp.gnu.org/gnu/$(GARNAME)/releases/$(DISTNAME)/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = GPL2/LGPL2_1

DESCRIPTION =
define BLURB
endef

CROSSIMG ?= $(DESTIMG)
GARTARGET = $($(CROSSIMG)_GARHOST)

IMGDEPS += $(CROSSIMG)
$(CROSSIMG)_DEPENDS = devel/glibc
DEPENDS   = lang/c
BUILDDEPS = devel/make devel/binutils

WORKDIR   = $(WORKROOTDIR)/$(DESTIMG)_$(CROSSIMG).d
COOKIEDIR = $(COOKIEROOTDIR)/$(DESTIMG)_$(CROSSIMG).d

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS  = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) --target=$(GARTARGET) \
	--with-local-prefix=$(patsubst %/include,%,$($(CROSSIMG)_includedir)) \
	--with-gnu-as \
	--with-gnu-ld \
	--enable-clocale=gnu \
	--enable-shared \
	--enable-threads=posix \
	--enable-__cxa_atexit \
	--disable-multilib \
	--enable-languages=c,c++ \
	--enable-version-specific-runtime-libs
ifneq ($(DESTIMG),$(CROSSIMG))
CONFIGURE_ARGS += \
	--with-sysroot=$($(CROSSIMG)_DESTDIR)
endif
# Bootstrap the native environment compiler.
ifeq ("$(DESTIMG)+$(CROSSIMG)","build+build")
BUILD_ARGS     += \
	bootstrap
endif

GAR_EXTRA_CONF += devel/glibc/package-api.mk
include ../../gar.mk


post-install:
	@rm -f $(CROSS_GCC_LIBDIR)/libstdc++.la ;
	@rm -f $(CROSS_GCC_LIBDIR)/libsupc++.la ;
	@$(if $(filter     $(DESTIMG),$(CROSSIMG)), \
		rm -f $(DESTDIR)$(libdir)/libstdc++.la ; \
		rm -f $(DESTDIR)$(libdir)/libsupc++.la ; \
		ln -sf gcc $(DESTDIR)$(bindir)/cc ; \
	)
	@$(if $(filter-out $(DESTIMG),$(CROSSIMG)), \
		mkdir -p $(DESTDIR)$(prefix)/$(GARHOST)/bin ; \
		cp $(DESTDIR)$(bindir)/$(GARTARGET)-cpp $(DESTDIR)$(prefix)/$(GARTARGET)/bin/cpp ; \
		cp $(DESTDIR)$(bindir)/$(GARTARGET)-gcc $(DESTDIR)$(prefix)/$(GARTARGET)/bin/cc ; \
	)
	@$(MAKECOOKIE)
