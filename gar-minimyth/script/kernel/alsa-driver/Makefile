GARNAME = alsa-driver
GARVERSION = $(ALSA_VERSION)
CATEGORIES = lib
MASTER_SITES = ftp://ftp.alsa-project.org/pub/driver/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-MVIAC3_2.patch
LICENSE = LGPL2_1

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c kernel/linux

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

DEFAULT_ARGS   = \
	HOSTCC="$(build_CC)" \
	HOSTCXX="$(build_CXX)" \
	HOSTCFLAGS="$(build_CFLAGS)" \
	HOSTCXXFLAGS="$(build_CXXFLAGS)" \
	AS="$(AS)" \
	LD="$(LD)" \
	CC="$(CC)" \
	CPP="$(CPP)" \
	AR="$(AR)" \
	NM="$(NM)" \
	STRIP="$(STRIP)" \
	OBJCOPY="$(OBJCOPY)" \
	OBJDUMP="$(OBJDUMP)"
CONFIGURE_ARGS = $(DIRPATHS) \
	--with-gnu-ld \
	--with-cross="$(compiler_prefix)" \
	--with-kernel="$(DESTDIR)$(KERNEL_BUILDDIR)" \
	--with-build="$(DESTDIR)$(KERNEL_BUILDDIR)" \
	--with-redhat=no \
	--with-suse=no \
	--with-moddir="$(KERNEL_MODULESDIR)/misc/alsa" \
	--with-sequencer=yes \
	--with-oss=yes \
	--with-cards="via82xx"
BUILD_ARGS     = $(DEFAULT_ARGS)
INSTALL_ARGS   = $(DEFAULT_ARGS)

CONFIGURE_ENV  = KBUILD_VERBOSE=1
BUILD_ENV      = KBUILD_VERBOSE=1
INSTALL_ENV    = KBUILD_VERBOSE=1 IUSER="$(IUSER)" IGROUP="$(IGROUP)"

GAR_EXTRA_CONF += kernel/linux/package-api.mk
include ../../gar.mk

IUSER  := `id -un`
IGROUP := `id -gn`

