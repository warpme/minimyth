GARNAME = alsa-driver
GARVERSION = $(ALSA_VERSION)
CATEGORIES = lib
MASTER_SITES = ftp://ftp.alsa-project.org/pub/driver/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-MVIAC3_2.patch $(DISTNAME)-depmod.patch $(DISTNAME)-asus_hack.patch
LICENSE = LGPL2_1

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c kernel/linux

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) \
	--with-gnu-ld \
	--with-kernel="$(DESTDIR)$(KERNEL_BUILDDIR)" \
	--with-build="$(DESTDIR)$(KERNEL_BUILDDIR)" \
	--with-redhat=no \
	--with-suse=no \
	--with-moddir="$(KERNEL_MODULESDIR)/misc/alsa" \
	--with-isapnp=no \
	--with-sequencer=yes \
	--with-oss=no \
	--with-cards="hda-intel,via82xx"
BUILD_ARGS     = $(KERNEL_MAKE_ARGS)
INSTALL_ARGS   = $(KERNEL_MAKE_ARGS)

CONFIGURE_ENV = $(KERNEL_MAKE_ENV)
BUILD_ENV     = $(KERNEL_MAKE_ENV)
INSTALL_ENV   = $(KERNEL_MAKE_ENV) IUSER="$(IUSER)" IGROUP="$(IGROUP)"

GAR_EXTRA_CONF += kernel/linux/package-api.mk
include ../../gar.mk

IUSER  := `id -un`
IGROUP := `id -gn`
