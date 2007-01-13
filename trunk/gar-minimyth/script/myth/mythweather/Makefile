GARNAME = mythweather
GARVERSION = $(MYTHTV_VERSION)
CATEGORIES = myth
MASTER_SITES  = http://www.mythtv.org/mc/
MASTER_SITES += cvs://mythtv:mythtv@cvs.mythtv.org:/var/lib/mythcvs/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME).patch.gar
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c myth/mythtv

CONFIGURE_SCRIPTS += $(WORKSRC)/$(GARNAME)/mythtv
BUILD_SCRIPTS     += $(WORKSRC)/$(GARNAME)/Makefile
INSTALL_SCRIPTS   += $(WORKSRC)/$(GARNAME)/Makefile

CONFIGURE_ENV += \
	DESTDIR="$(DESTDIR)" \
	QTDIR="$(DESTDIR)$(qtprefix)" \
	OPTFLAGS="$(CFLAGS)"
BUILD_ENV     += \
	DESTDIR="$(DESTDIR)" \
	QTDIR="$(DESTDIR)$(qtprefix)" \
	OPTFLAGS="$(CFLAGS)"
INSTALL_ARGS  += \
	INSTALL_ROOT="$(DESTDIR)"

GAR_EXTRA_CONF += myth/mythtv/package-api.mk
include ../../gar.mk

cvs//%/$(DISTNAME).tar.bz2:
	@cd $(PARTIALDIR); rm -rf $(GARNAME)
	@cd $(PARTIALDIR); cvs -z3 -d:pserver:$* co -D $(GARVERSION) $(GARNAME)
	@cd $(PARTIALDIR); rm -rf $(DISTNAME)
	@cd $(PARTIALDIR); mv $(GARNAME) $(DISTNAME)
	@cd $(PARTIALDIR); tar -jc $(DISTNAME) -f $(DISTNAME).tar.bz2
	@cd $(PARTIALDIR); rm -rf $(DISTNAME)
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

configure-%/mythtv:
	@cd $* ; $(CONFIGURE_ENV) qmake $(GARNAME).pro
	@$(MAKECOOKIE)
