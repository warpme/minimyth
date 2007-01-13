GARNAME = aewm
GARVERSION = 1.3.1
CATEGORIES = X11
MASTER_SITES = http://www.red-bean.com/~decklin/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME).patch
LICENSE = aewm
aewm_LICENSE_TEXT = $(WORKSRC)/LICENSE

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c X11/X11 X11/freetype X11/lesstif

BUILD_SCRIPTS   = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = $(WORKSRC)/Makefile

DEFAULT_ARGS = \
	CC="$(CC)" \
	CFLAGS="$(CFLAGS)" \
	DESTDIR="$(DESTDIR)" \
	XROOT="$(x11prefix)" \
	BINDIR="$(DESTDIR)$(bindir)" \
	INCLUDEDIR="$(DESTDIR)$(x11includedir)" \
	LIBDIR="$(DESTDIR)$(x11libdir)" \
	MANDIR="$(DESTDIR)$(mandir)/man1" \
	CFGDIR="$(DESTDIR)$(x11sysconfdir)/aewm" \
	GTKPROGS=""
BUILD_ARGS   = $(DEFAULT_ARGS)
INSTALL_ARGS = $(DEFAULT_ARGS)

include ../../gar.mk

post-install:
	@mv -f $(DESTDIR)$(bindir)/aemenu-xaw  $(DESTDIR)$(bindir)/aemenu
	@mv -f $(DESTDIR)$(bindir)/aepanel-xaw $(DESTDIR)$(bindir)/aepanel
	@$(MAKECOOKIE)
