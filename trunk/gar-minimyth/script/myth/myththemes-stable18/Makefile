GARNAME = myththemes
GARVERSION = 0.18
CATEGORIES = myth
MASTER_SITES = http://www.mythtv.org/mc/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME).patch.gar
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c myth/mythtv-stable18

CONFIGURE_SCRIPTS = $(WORKSRC)/mythtv
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ENV = \
	DESTDIR="$(DESTDIR)" \
	QTDIR="$(DESTDIR)$(qtprefix)" \
	QMAKESPEC="default" \
	OPTFLAGS="$(CFLAGS)"
INSTALL_ENV   = \
	DESTDIR="$(DESTDIR)" \
	QTDIR="$(DESTDIR)$(qtprefix)" \
	QMAKESPEC="default" \
	OPTFLAGS="$(CFLAGS)" \
	INSTALL_ROOT="$(DESTDIR)"

GAR_EXTRA_CONF += myth/mythtv-stable18/package-api.mk
include ../../gar.mk

configure-%/mythtv:
	cd $* ; $(CONFIGURE_ENV) qmake $(GARNAME).pro
	$(MAKECOOKIE)
