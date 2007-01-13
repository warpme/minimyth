GARNAME = splashutils
GARVERSION = 1.3
CATEGORIES = system
MASTER_SITES = http://dev.gentoo.org/~spock/projects/gensplash/archive/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME).patch.gar
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c kernel/linux lib/libjpeg lib/zlib lib/freetype

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
	QUIET="true" \
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

GAR_EXTRA_CONF += kernel/linux/package-api.mk
include ../../gar.mk

configure-kernel:
	@rm -rf $(WORKSRC)/linux
	@ln -s $(DESTDIR)$(KERNEL_SOURCEDIR) $(WORKSRC)/linux
	@$(MAKECOOKIE)
