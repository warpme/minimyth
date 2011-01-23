GARNAME = glibc
GARVERSION = $(GLIBC_VERSION)
CATEGORIES = devel
MASTER_SITES  = http://ftp.gnu.org/gnu/$(GARNAME)/
MASTER_SITES += ftp://sources.redhat.com/pub/$(GARNAME)/snapshots/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-select_fd_type.patch $(DISTNAME)-__i686.patch $(DISTNAME)-build_locale.patch $(DISTNAME)-perl.patch.gar $(DISTNAME).patch $(DISTNAME)-ldd.patch
LICENSE = GPL2/LGPL2_1

DESCRIPTION = 
define BLURB
endef

ifeq ($(DESTIMG),build)
DEPENDS   = lang/c
BUILDDEPS = devel/binutils devel/gcc
else
DEPENDS   = lang/c kernel-headers/linux-headers devel/glibc-headers
BUILDDEPS = devel/binutils devel/gcc-minimal-shared
endif

# If this is the build image and the system is using linuxthreads, then we need to use linux threads.
# Otherwise, the build packages will not compile and run correctly.
use_linuxthreads = no
ifeq ($(DESTIMG),build)
ifeq ($(shell getconf GNU_LIBPTHREAD_VERSION | sed 's%[- ].*%%'),linuxthreads)
use_linuxthreads = yes
endif
endif

WORKBLD = $(WORKSRC)_build

CONFIGURE_SCRIPTS = custom
BUILD_SCRIPTS     = $(WORKBLD)/Makefile
INSTALL_SCRIPTS   = $(WORKBLD)/Makefile

CONFIGURE_ARGS  = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-bind-now \
	--enable-kernel=2.6.36 \
	--with-binutils=$(build_DESTDIR)$(build_bindir) \
	--without-gd \
	--without-cvs \
	--with-elf \
	--with-headers=$(DESTDIR)$(includedir) \
	--cache-file=config.cache
ifeq ($(use_linuxthreads),yes)
CONFIGURE_ARGS += \
	--enable-add-ons=linuxthreads \
	--without-tls \
	--without-__thread
else
CONFIGURE_ARGS += \
	--enable-add-ons=nptl \
	--with-tls \
	--with-__thread
endif
INSTALL_ARGS    = \
	install_root=$(DESTDIR)

GAR_EXTRA_CONF += devel/glibc/package-api.mk
include ../../gar.mk

# Fails to compile using the gold linker.
CFLAGS  := $(filter-out -fuse-ld=gold -fuse-linker-plugin, $(CFLAGS))
LDFLAGS := $(filter-out -fuse-ld=gold -fuse-linker-plugin, $(LDFLAGS))

# Fails to compile with GCC's link time optimization.
CFLAGS  := $(filter-out -flto -fuse-linker-plugin, $(CFLAGS))
LDFLAGS := $(filter-out -flto -fuse-linker-plugin, $(LDFLAGS))

CFLAGS := $(filter-out -ffast-math, $(CFLAGS))
CFLAGS := $(filter-out -O%, $(CFLAGS)) -O3

pre-configure:
	@mkdir -p $(WORKBLD)
	@rm -rf $(WORKBLD)/configparms
	@echo "slibdir=$(elibdir)" >> $(WORKBLD)/configparms
	@rm -rf $(WORKBLD)/config.cache
	@echo "libc_cv_forced_unwind=yes" >> $(WORKBLD)/config.cache
	@echo "libc_cv_c_cleanup=yes"     >> $(WORKBLD)/config.cache
	@$(MAKECOOKIE)

configure-custom:
	@mkdir -p $(WORKBLD)
	@cd $(WORKBLD) && $(CONFIGURE_ENV) ./$(call DIRSTODOTS,$(WORKBLD))/$(WORKSRC)/configure $(CONFIGURE_ARGS)
	@$(MAKECOOKIE)

post-install:
	@cd $(DESTDIR)$(datadir)/i18n/charmaps ; gzip -d *.gz
	@$(MAKECOOKIE)