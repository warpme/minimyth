GARNAME = mythstream
GARVERSION = v0.17_2
CATEGORIES = myth
MASTER_SITES = http://home.kabelfoon.nl/~moongies/sw9vc4htz2/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME).patch.gar $(DISTNAME)-parser_exec.patch $(DISTNAME)-font.patch $(DISTNAME)-x86_64.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c qt/qt myth/mythtv-svn lib/fftw

WORKSRC = $(WORKDIR)/$(GARNAME)-0.17_2

CONFIGURE_SCRIPTS = $(WORKSRC)/mythtv
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ENV = \
	DESTDIR="$(DESTDIR)" \
	QTDIR="$(DESTDIR)$(qtprefix)" \
	QMAKESPEC="default" \
	OPTFLAGS="$(CFLAGS)"
BUILD_ENV     = \
	DESTDIR="$(DESTDIR)" \
	QTDIR="$(DESTDIR)$(qtprefix)" \
	QMAKESPEC="default" \
	OPTFLAGS="$(CFLAGS)"
INSTALL_ARGS  = \
	DESTDIR="$(DESTDIR)" \
	QTDIR="$(DESTDIR)$(qtprefix)" \
	QMAKESPEC="default" \
	OPTFLAGS="$(CFLAGS)" \
	INSTALL_ROOT="$(DESTDIR)"

include ../../gar.mk

configure-%/mythtv:
	@cd $* ; $(CONFIGURE_ENV) qmake $(GARNAME).pro
	@$(MAKECOOKIE)
