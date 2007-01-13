GARNAME = udev
GARVERSION = 096
CATEGORIES = system
MASTER_SITES = ftp://ftp.kernel.org/pub/linux/utils/kernel/hotplug/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

BUILD_SCRIPTS   = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = $(WORKSRC)/Makefile

DEFAULT_ARGS = \
	V=true \
	INSTALL="install" \
	HOSTCC="$(build_CC)" \
	CROSS_COMPILE="$(compiler_prefix)" \
	CC="$(CC)" \
	LD="$(CC)" \
	AR="$(AR)" \
	STRIP="$(STRIP)" \
	RANLIB="$(RANLIB)" \
	DESTDIR="$(DESTDIR)" \
	prefix="$(prefix)" \
	exec_prefix="$(exec_prefix)" \
	etcdir="$(etcdir)" \
	sbindir="$(sbindir)" \
	usrbindir="$(usrbindir)" \
	usrsbindir="$(usrsbindir)" \
	libudevdir="${libudevdir}" \
	mandir="$(mandir)" \
	configdir="$(configdir)" \
	udevdir="$(udevdir)"

BUILD_ARGS   = $(DEFAULT_ARGS) EXTRAS="extras/cdrom_id/ extras/volume_id/"
INSTALL_ARGS = $(DEFAULT_ARGS) EXTRAS="extras/cdrom_id/ extras/volume_id/"

include ../../gar.mk

prefix      := $(prefix)
exec_prefix := $(exec_prefix)
etcdir      := $(sysconfdir)
sbindir     := $(esbindir)
usrbindir   := $(bindir)
usrsbindir  := $(sbindir)
libudevdir  := ${elibdir}/udev
mandir      := $(mandir)
configdir   := $(sysconfdir)/udev
udevdir     := $(rootdir)/dev

pre-install:
	@rm -rf $(DESTDIR)$(sysconfdir)/udev
	@$(MAKECOOKIE)
