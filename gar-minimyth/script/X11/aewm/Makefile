GARNAME = aewm
GARVERSION = 1.3.0
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
	MANDIR="$(DESTDIR)$(mandir)/man1" \
	GTKPROGS=""
BUILD_ARGS   = $(DEFAULT_ARGS)
INSTALL_ARGS = $(DEFAULT_ARGS)

include ../../gar.mk

post-install:
	@mv -f $(DESTDIR)$(x11bindir)/aemenu-xaw  $(DESTDIR)$(x11bindir)/aemenu
	@mv -f $(DESTDIR)$(x11bindir)/aepanel-xaw $(DESTDIR)$(x11bindir)/aepanel
	@$(MAKECOOKIE)
