GARNAME = splashutils
GARVERSION = 1.3
CATEGORIES = system
MASTER_SITES = http://dev.gentoo.org/~spock/projects/gensplash/archive/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-config_opt.patch $(DISTNAME).patch.gar
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c kernel/kernel lib/libjpeg lib/zlib lib/freetype

CONFIGURE_SCRIPTS = $(WORKSRC)/configure kernel
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = \
	--without-fbsplash \
	--with-fifo="$(localstatedir)/cache/splash/fifo" \
	--without-mng \
	--without-png \
	--with-themedir="$(sysconfdir)/splash" \
	--with-ttf \
	--with-ttfkern
BUILD_ARGS = \
	QUIET="false" \
	KLCC="$(CC)" \
	CC="$(CC)" \
	CFLAGS="$(CFLAGS)" \
	LDFLAGS="$(LDFLAGS)" \
	STRIP="$(STRIP)" \
	LIBDIR="$(DESTDIR)$(libdir)" \
	prefix="$(prefix)" \
	sbindir="$(esbindir)" \
	usrbindir="$(bindir)" \
	mandir="$(mandir)"

GAR_EXTRA_CONF += kernel-$(mm_KERNEL_VERSION)/linux/package-api.mk
include ../../gar.mk

configure-kernel:
	@rm -rf $(WORKSRC)/linux
	@ln -s $(DESTDIR)$(LINUX_SOURCEDIR) $(WORKSRC)/linux
	@$(MAKECOOKIE)
