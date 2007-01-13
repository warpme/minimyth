GARNAME = myththemes
GARVERSION = $(mm_MYTH_SVN_VERSION)
CATEGORIES = myth
MASTER_SITES = svn://svn.mythtv.org/svn/trunk/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(GARNAME).patch.gar $(GARNAME)-preserve_timestamps.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c myth/mythtv-svn

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

GAR_EXTRA_CONF += myth/mythtv-svn/package-api.mk
include ../../gar.mk

svn//%/$(DISTNAME).tar.bz2:
	@$(call FETCH_SVN, http://$*, $(GARVERSION), $(DISTNAME))
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

configure-%/mythtv:
	@cd $* ; $(CONFIGURE_ENV) qmake $(GARNAME).pro
	@$(MAKECOOKIE)
