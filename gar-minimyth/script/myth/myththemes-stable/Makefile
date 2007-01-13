GARNAME = myththemes
GARVERSION = 0.18
CATEGORIES = myth
MASTER_SITES  = http://www.mythtv.org/mc/
MASTER_SITES += svn://svn.mythtv.org/svn/trunk/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME).patch.gar
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c myth/mythtv-stable

CONFIGURE_SCRIPTS += $(WORKSRC)/mythtv
INSTALL_SCRIPTS   += $(WORKSRC)/Makefile

CONFIGURE_ENV += \
	DESTDIR="$(DESTDIR)" \
	QTDIR="$(DESTDIR)$(qtprefix)" \
	QMAKESPEC="default" \
	OPTFLAGS="$(CFLAGS)"
INSTALL_ARGS  += \
	DESTDIR="$(DESTDIR)" \
	QTDIR="$(DESTDIR)$(qtprefix)" \
	QMAKESPEC="default" \
	OPTFLAGS="$(CFLAGS)" \
	INSTALL_ROOT="$(DESTDIR)"

GAR_EXTRA_CONF += myth/mythtv-stable/package-api.mk
include ../../gar.mk

svn//%/$(DISTNAME).tar.bz2:
	@cd $(PARTIALDIR); rm -rf $(GARNAME)
	@cd $(PARTIALDIR); svn co -r $(GARVERSION) http://$*
	@cd $(PARTIALDIR); rm -rf $(DISTNAME)
	@cd $(PARTIALDIR); mv $(GARNAME) $(DISTNAME)
	@cd $(PARTIALDIR); tar -jcf $(DISTNAME).tar.bz2 $(DISTNAME)
	@cd $(PARTIALDIR); rm -rf $(DISTNAME)
	@$(MAKECOOKIE)

disabled-checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

configure-%/mythtv:
	cd $* ; $(CONFIGURE_ENV) qmake $(GARNAME).pro
	$(MAKECOOKIE)
