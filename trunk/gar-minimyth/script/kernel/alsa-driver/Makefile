GARNAME = alsa-driver
GARVERSION = 1.0.12
CATEGORIES = lib
MASTER_SITES = ftp://ftp.alsa-project.org/pub/driver/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-depmod.patch $(DISTNAME)-ac97_vt1617a.patch
LICENSE = LGPL2_1

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c kernel/linux

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile


CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) \
	--with-cross="$(compiler_prefix)" \
	--with-kernel="$(DESTDIR)$(KERNEL_BUILDDIR)" \
	--with-build="$(DESTDIR)$(KERNEL_BUILDDIR)" \
	--with-redhat=no \
	--with-suse=no \
	--with-moddir="$(KERNEL_MODULESDIR)/misc/alsa" \
	--with-isapnp=no \
	--with-sequencer=yes \
	--with-oss=no \
	--with-cards="hda-intel,intel8x0,usb-audio,via82xx"

CONFIGURE_ENV = $(KERNEL_MAKE_ENV)
BUILD_ENV     = $(KERNEL_MAKE_ENV)
INSTALL_ENV   = $(KERNEL_MAKE_ENV) IUSER="$(IUSER)" IGROUP="$(IGROUP)"

GAR_EXTRA_CONF += kernel/linux/package-api.mk
include ../../gar.mk

CC       := 
CPPFLAGS :=
CFLAGS   :=
LDFLAGS  :=

IUSER  := `id -u`
IGROUP := `id -g`

clean-all:
	@$(MAKE) clean
	@rm -rf "$(DESTDIR)$(KERNEL_MODULESDIR)/misc/alsa/"
