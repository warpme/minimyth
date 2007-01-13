GARNAME = gcc
GARVERSION = $(GCC_VERSION)
CATEGORIES = devel
MASTER_SITES  = ftp://ftp.gnu.org/gnu/$(GARNAME)/$(DISTNAME)/
MASTER_SITES += ftp://ftp.gnu.org/gnu/$(GARNAME)/releases/$(DISTNAME)/
MASTER_SITES += ftp://gcc.gnu.org/pub/gcc/releases/$(DISTNAME)/
MASTER_SITES += ftp://gcc.gnu.org/pub/gcc/snapshots/$(GCC_VERSION)/
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

WORKBLD = $(WORKSRC)_build

CONFIGURE_SCRIPTS = custom
BUILD_SCRIPTS     = $(WORKBLD)/Makefile
INSTALL_SCRIPTS   = $(WORKBLD)/Makefile

CONFIGURE_ARGS  = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) --target=$(GARTARGET) \
	--with-gnu-as \
	--with-gnu-ld \
	--with-local-prefix=$(patsubst %/include,%,$($(CROSSIMG)_includedir)) \
	--enable-__cxa_atexit \
	--enable-clocale=gnu \
	--enable-languages=c,c++ \
	--disable-libmudflap \
	--disable-multilib \
	--enable-nls \
	--enable-shared \
	--enable-threads=posix \
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

CPPFLAGS :=
CFLAGS   :=
CXXFLAGS :=
LDFLAGS  :=

configure-custom:
	@mkdir -p $(WORKBLD)
	@cd $(WORKBLD) && $(CONFIGURE_ENV) ./$(call DIRSTODOTS,$(WORKBLD))/$(WORKSRC)/configure $(CONFIGURE_ARGS)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(CROSS_GCC_LIBDIR)/libstdc++.la
	@rm -f $(CROSS_GCC_LIBDIR)/libsupc++.la
	@$(if $(filter     $(DESTIMG),$(CROSSIMG)), \
		rm -f $(DESTDIR)$(libdir)/libstdc++.la ; \
		rm -f $(DESTDIR)$(libdir)/libsupc++.la ; \
		ln -sf gcc $(DESTDIR)$(bindir)/cc ; \
	)
	@$(if $(filter-out $(DESTIMG),$(CROSSIMG)), \
		$(if $(wildcard $(CROSS_GCC_DIR)/lib64), \
			mv -f $(CROSS_GCC_DIR)/lib64/* $(CROSS_GCC_LIBDIR) ; \
			rm -rf $(CROSS_GCC_DIR)/lib64 ; \
		) \
		$(if $(wildcard $(CROSS_GCC_LIBDIR)/specs), \
			sed -i 's%/lib64%/lib%' $(DESTDIR)$(CROSS_GCC_LIBDIR)/specs ; \
		) \
		mkdir -p $(DESTDIR)$(prefix)/$(GARHOST)/bin ; \
		cp $(DESTDIR)$(bindir)/$(GARTARGET)-cpp $(DESTDIR)$(prefix)/$(GARTARGET)/bin/cpp ; \
		cp $(DESTDIR)$(bindir)/$(GARTARGET)-gcc $(DESTDIR)$(prefix)/$(GARTARGET)/bin/cc ; \
	)
	@$(MAKECOOKIE)
