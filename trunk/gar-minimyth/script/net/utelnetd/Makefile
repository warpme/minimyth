GARNAME = utelnetd
GARVERSION = 0.1.9
CATEGORIES = net
MASTER_SITES = http://www.pengutronix.de/software/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-install.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

BUILD_SCRIPTS   = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = $(WORKSRC)/Makefile

BUILD_ARGS   = CC="$(CC)" LOGIN="$(ebindir)/sh" INSTDIR="$(DESTDIR)$(bindir)"
INSTALL_ARGS = CC="$(CC)" LOGIN="$(ebindir)/sh" INSTDIR="$(DESTDIR)$(bindir)"

include ../../gar.mk
