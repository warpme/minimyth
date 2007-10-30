GARNAME = powertop
GARVERSION = 1.9
CATEGORIES = utils
MASTER_SITES = http://www.linuxpowertop.org/download/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/ncursesw

BUILD_SCRIPTS   = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = $(WORKSRC)/Makefile

BUILD_ARGS   = \
	BINDIR=$(bindir)
	LOCALESDIR=$(datadir)/locale
	MANDIR=$(mandir)/man1
INSTALL_ARGS = \
	BINDIR=$(bindir)
	LOCALESDIR=$(datadir)/locale
	MANDIR=$(mandir)/man1

include ../../gar.mk
