GARNAME = util-linux-ng
GARVERSION = 2.15
CATEGORIES = utils
MASTER_SITES = ftp://ftp.kernel.org/pub/linux/utils/util-linux-ng/v2.15/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-blkid.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/libuuid lib/ncursesw lib/zlib

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--bindir=$(ebindir) \
	--sbindir=$(esbindir) \
	--libdir=$(elibdir) \
	--enable-shared \
	--disable-static \
	--disable-rpath \
	--enable-arch \
	--disable-use-tty-group \
	--with-fsprobe=builtin \
	--with-gnu-ld

BUILD_ARGS     = \
	usrbinexecdir=$(bindir) \
	usrsbinexecdir=$(sbindir)
INSTALL_ARGS   = \
	usrbinexecdir=$(bindir) \
	usrsbinexecdir=$(sbindir)

include ../../gar.mk

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)
