GARNAME = splashutils
GARVERSION = 1.4.2.1
CATEGORIES = system
MASTER_SITES = http://dev.gentoo.org/~spock/projects/gensplash/archive/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-makefile.patch $(DISTNAME).patch.gar
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c kernel/kernel lib/libjpeg lib/zlib lib/freetype

CONFIGURE_SCRIPTS = $(WORKSRC)/configure kernel
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = \
	--without-deprecated \
	--without-fbsplash \
	--with-fifo="$(localstatedir)/cache/splash/fifo" \
	--without-gentoo \
	--without-gpm \
	--without-mng \
	--without-png \
	--with-themedir="$(sysconfdir)/splash" \
	--with-ttf \
	--with-ttfkern
BUILD_ARGS = \
	QUIET="false" \
	CC="$(CC)" \
	KLCC="$(CC)" \
	LIB="usr/lib" \
	INSTALL="install" \
	CFLAGS="$(CFLAGS)" \
	LDFLAGS="$(LDFLAGS)" \
	STRIP="$(STRIP)" \
	prefix="$(prefix)" \
	sbindir="$(esbindir)" \
	libdir="$(libdir)" \
	usrbindir="$(bindir)" \
	mandir="$(mandir)"

GAR_EXTRA_CONF += kernel-$(mm_KERNEL_VERSION)/linux/package-api.mk
include ../../gar.mk

configure-kernel:
	@rm -rf $(WORKSRC)/linux
	@ln -s $(DESTDIR)$(LINUX_SOURCEDIR) $(WORKSRC)/linux
	@$(MAKECOOKIE)
