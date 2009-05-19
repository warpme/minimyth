GARNAME = sysvinit
GARVERSION = 2.86
CATEGORIES = system
MASTER_SITES = ftp://ftp.cistron.nl/pub/people/miquels/sysvinit/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-init_silent.patch $(DISTNAME)-makefile.patch $(DISTNAME)-halt.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

BUILD_SCRIPTS   = $(WORKSRC)/src/Makefile
INSTALL_SCRIPTS = $(WORKSRC)/src/Makefile

DEFAULT_ARGS = \
	CC="$(CC)" \
        CFLAGS="$(CFLAGS) -D_GNU_SOURCE" \
        LDFLAGS="$(CFLAGS)" \
	INSTALL="install" \
	ROOT="$(DESTDIR)" \
	MANDIR="$(mandir)" \
	CONFDIR="$(sysconfdir)" \
	BINDIR="$(ebindir)" \
	USRBINDIR="$(bindir)" \
	SBINDIR="$(esbindir)" \
	USRLIBDIR="$(libdir)" \
	INCLUDEDIR="$(includedir)"
BUILD_ARGS   = $(DEFAULT_ARGS)
INSTALL_ARGS = $(DEFAULT_ARGS)

include ../../gar.mk
