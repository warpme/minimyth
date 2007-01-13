GARNAME = gcc
GARVERSION = $(GCC_VERSION)
CATEGORIES = devel
MASTER_SITES  = ftp://ftp.gnu.org/gnu/$(GARNAME)/$(GARNAME)-$(GARVERSION)/
MASTER_SITES += ftp://ftp.gnu.org/gnu/gcc/releases/$(GARNAME)-$(GARVERSION)/
DISTFILES = $(GARNAME)-$(GARVERSION).tar.bz2
PATCHFILE_FIXINCLUDES = $(GARNAME)-$(GARVERSION)-no_fixincludes-1.patch
PATCHFILE_SPECS = $(GARNAME)-$(GARVERSION)-specs-1.patch
LICENSE = GPL2/LGPL2_1

DESCRIPTION =
define BLURB
endef

ifndef GCC_DISABLE_PATCH
PATCHFILES = $(PATCHFILE_FIXINCLUDES) $(PATCHFILE_SPECS)
endif

CROSSIMG ?= $(DESTIMG)
GARTARGET = $($(CROSSIMG)_GARHOST)

IMGDEPS += $(CROSSIMG)
$(CROSSIMG)_DEPENDS = devel/glibc
DEPENDS = lang/c

WORKDIR   = $(WORKROOTDIR)/$(DESTIMG)_$(CROSSIMG).d
COOKIEDIR = $(COOKIEROOTDIR)/$(DESTIMG)_$(CROSSIMG).d
PATCHDIR  = $(WORKSRC)

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS  = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) --target=$(GARTARGET) \
	--with-local-prefix=$(patsubst %/include,%,$($(CROSSIMG)_includedir)) \
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

GAR_EXTRA_CONF += devel/glibc/package-api.mk
include ../../gar.mk

patch-$(PATCHFILE_SPECS):
	@cat $(DOWNLOADDIR)/$(PATCHFILE_SPECS) \
		| sed "s%_GAR_ELIBDIR%$($(CROSSIMG)_elibdir)%g"   \
		| sed "s%_GAR_ELIB32DIR%$($(CROSSIMG)_elibdir)%g" \
		| sed "s%_GAR_ELIB64DIR%$($(CROSSIMG)_elibdir)%g" \
		| sed "s%_GAR_LIBDIR%$($(CROSSIMG)_libdir)%g"     \
		| sed "s%_GAR_LIB32DIR%$($(CROSSIMG)_libdir)%g"   \
		| sed "s%_GAR_LIB64DIR%$($(CROSSIMG)_libdir)%g"   \
		| $(GARPATCH)
	@$(MAKECOOKIE)

post-install:
	@test ! $(DESTIMG) = $(CROSSIMG) && rm -f $(CROSS_GCC_LIBDIR)/libstdc++.la
	@test ! $(DESTIMG) = $(CROSSIMG) && rm -f $(CROSS_GCC_LIBDIR)/libsupc++.la
	@test ! $(DESTIMG) = $(CROSSIMG) && mkdir -p $(DESTDIR)$(prefix)/$(GARHOST)/bin
	@test ! $(DESTIMG) = $(CROSSIMG) && cp $(DESTDIR)$(bindir)/$(GARTARGET)-cpp $(DESTDIR)$(prefix)/$(GARTARGET)/bin/cpp
	@test ! $(DESTIMG) = $(CROSSIMG) && cp $(DESTDIR)$(bindir)/$(GARTARGET)-gcc $(DESTDIR)$(prefix)/$(GARTARGET)/bin/cc
	@$(MAKECOOKIE)
