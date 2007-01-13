GARNAME = udev
GARVERSION = 052
CATEGORIES = system
MASTER_SITES = ftp://ftp.kernel.org/pub/linux/utils/kernel/hotplug/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c kernel/linux

BUILD_SCRIPTS   = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = $(WORKSRC)/Makefile

DEFAULT_ARGS = \
	V=true \
	HOSTCC="$(build_CC)" \
	CROSS="$(compiler_prefix)" \
	CC="$(CC)" \
	LD="$(CC)" \
	AR="$(AR)" \
	STRIP="$(STRIP)" \
	RANLIB="$(RANLIB)" \
	DESTDIR="$(DESTDIR)" \
	KERNEL_DIR="$(DESTDIR)$(KERNEL_BUILDDIR)" \
	ARCH="$(KERNEL_ARCH)" \
	prefix="$(prefix)" \
	exec_prefix="$(exec_prefix)" \
	etcdir="$(etcdir)" \
	sbindir="$(sbindir)" \
	usrbindir="$(usrbindir)" \
	mandir="$(mandir)" \
	hotplugdir="$(hotplugdir)" \
	configdir="$(configdir)" \
	initdir="$(initdir)" \
	dev_ddir="$(dev_ddir)" \
	udevdir="$(udevdir)"
BUILD_ARGS   = $(DEFAULT_ARGS)
INSTALL_ARGS = $(DEFAULT_ARGS)

GAR_EXTRA_CONF += kernel/linux/package-api.mk
include ../../gar.mk

prefix      := $(prefix)
exec_prefix := $(exec_prefix)
etcdir      := $(sysconfdir)
sbindir     := $(esbindir)
usrbindir   := $(bindir)
mandir      := $(mandir)
hotplugdir  := $(sysconfdir)/hotplug.d/default
configdir   := $(sysconfdir)/udev
initdir     := $(sysconfdir)/init.d
dev_ddir    := $(sysconfdir)/dev.d
udevdir     := $(rootdir)/dev

pre-install:
	@rm -rf $(DESTDIR)$(sysconfdir)/dev.d
	@rm -rf $(DESTDIR)$(sysconfdir)/udev
	@$(MAKECOOKIE)

post-install:
	@sed -i 's%\(.*SYMLINK="cdrom".*\)%#\1%' $(DESTDIR)$(configdir)/rules.d/50-udev.rules
	@ln -sf udev $(DESTDIR)$(sbindir)/udevstart
	@ln -sf .$(call DIRSTODOTS, $(hotplugdir))$(sbindir)/udevsend $(DESTDIR)$(hotplugdir)/10-udev.hotplug
	@$(MAKECOOKIE)
