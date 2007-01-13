GARNAME = myththemes
GARVERSION = 0.19
CATEGORIES = myth
MASTER_SITES = http://www.mythtv.org/mc/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-fixes-$(MYTHTV_STABLE19_FIXES_VERSION).patch $(DISTNAME).patch.gar $(DISTNAME)-fadeaway.patch $(DISTNAME)-preserve_timestamps.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c myth/mythtv-stable19

CONFIGURE_SCRIPTS  = $(WORKSRC)/configure
CONFIGURE_SCRIPTS += $(WORKSRC)/mythtv
INSTALL_SCRIPTS    = $(WORKSRC)/Makefile

CONFIGURE_ARGS = \
	--prefix="$(prefix)"

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

GAR_EXTRA_CONF += myth/mythtv-stable19/package-api.mk
include ../../gar.mk

configure-%/mythtv:
	@cd $* ; $(CONFIGURE_ENV) qmake $(GARNAME).pro
	@$(MAKECOOKIE)

post-install:
	@install -d $(DESTDIR)$(versiondir) 
	@echo "$(GARVERSION) with fixes through SVN $(MYTHTV_STABLE19_FIXES_VERSION)" > $(DESTDIR)$(versiondir)/$(GARNAME)
	@$(MAKECOOKIE)
