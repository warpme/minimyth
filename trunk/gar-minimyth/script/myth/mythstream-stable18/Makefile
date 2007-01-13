GARNAME = mythstream
GARVERSION = v0.16_5
CATEGORIES = myth
MASTER_SITES = http://home.kabelfoon.nl/~moongies/sw9vc4htz2/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME).patch.gar $(DISTNAME)-fontsize.patch $(DISTNAME)-c++.patch $(DISTNAME)-x86_64.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c myth/mythtv-stable18 lib/fftw

WORKSRC = $(WORKDIR)/$(GARNAME)-0.16_5

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

GAR_EXTRA_CONF += myth/mythtv-stable18/package-api.mk
include ../../gar.mk

pre-configure:
	@ln -sf $(DESTDIR)$(MYTHTV_SOURCEDIR)/libs/libmyth $(WORKSRC)/mythstream/mythtv
	@$(MAKECOOKIE)

configure-%/mythtv:
	@cd $* ; $(CONFIGURE_ENV) qmake $(GARNAME).pro
	@$(MAKECOOKIE)
