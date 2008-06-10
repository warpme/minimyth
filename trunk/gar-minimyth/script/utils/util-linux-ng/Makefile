GARNAME = util-linux-ng
GARVERSION = 2.14
CATEGORIES = utils
MASTER_SITES = ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.14/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/ncurses lib/zlib utils/procps disk/e2fsprogs system/udev

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--bindir=$(ebindir) \
	--sbindir=$(esbindir) \
	--libdir=$(elibdir) \
	--disable-rpath \
	--enable-arch \
	--disable-use-tty-group \
	--with-fsprobe=volume_id \
	--with-gnu-ld

BUILD_ARGS     = \
	usrbinexecdir=$(bindir) \
	usrsbinexecdir=$(sbindir)
INSTALL_ARGS   = \
	usrbinexecdir=$(bindir) \
	usrsbinexecdir=$(sbindir)

include ../../gar.mk

PATH := $(PATH):$(build_DESTDIR)$(build_elibdir)/udev
