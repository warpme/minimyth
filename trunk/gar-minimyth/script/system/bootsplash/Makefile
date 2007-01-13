GARNAME = bootsplash
GARVERSION = 3.1
CATEGORIES = system
MASTER_SITES = ftp://ftp.openbios.org/pub/$(GARNAME)/rpm-sources/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/libmng X11/freetype

BUILD_SCRIPTS   = $(WORKSRC)/Utilities/Makefile
INSTALL_SCRIPTS = custom

BUILD_ARGS = \
	CC="$(CC)" \
	CFLAGS="$(CFLAGS)" \
	LDFLAGS="$(LDFLAGS)" \
	STRIP="$(STRIP)" \
	LIBDIR="$(DESTDIR)$(libdir)"

include ../../gar.mk

install-custom:
	@install -m 755 $(WORKSRC)/Utilities/fbmngplay    $(DESTDIR)$(esbindir)
	@install -m 755 $(WORKSRC)/Utilities/fbresolution $(DESTDIR)$(esbindir)
	@install -m 755 $(WORKSRC)/Utilities/fbtruetype   $(DESTDIR)$(esbindir)
	@install -m 755 $(WORKSRC)/Utilities/splash       $(DESTDIR)$(esbindir)
	@install -m 755 $(WORKSRC)/Utilities/splashpbm    $(DESTDIR)$(esbindir)
	@$(MAKECOOKIE)
