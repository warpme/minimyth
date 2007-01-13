GARNAME = mythweather
GARVERSION = $(MYTHTV_VERSION)
CATEGORIES = myth
MASTER_SITES = cvs://mythtv:mythtv@cvs.mythtv.org:/var/lib/mythcvs/
CONFIGFILE = settings.pro
DISTFILES = $(GARNAME)-$(GARVERSION).tar.bz2 $(CONFIGFILE)
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c myth/mythtv

CONFIGURE_SCRIPTS = custom
BUILD_SCRIPTS     = $(WORKSRC)/$(GARNAME)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/$(GARNAME)/Makefile

CONFIGURE_ENV = \
	DESTDIR="$(DESTDIR)" \
	QTDIR="$(DESTDIR)$(qtprefix)" \
	OPTFLAGS="$(CFLAGS)"
BUILD_ENV     = \
	DESTDIR="$(DESTDIR)" \
	QTDIR="$(DESTDIR)$(qtprefix)" \
	OPTFLAGS="$(CFLAGS)"
INSTALL_ARGS  = \
	INSTALL_ROOT="$(DESTDIR)"

GAR_EXTRA_CONF += myth/mythtv/package-api.mk
include ../../gar.mk

cvs//%/$(GARNAME)-$(GARVERSION).tar.bz2:
	@cd $(PARTIALDIR); rm -rf $(GARNAME)
	@cd $(PARTIALDIR); cvs -z3 -d:pserver:$* co -D $(GARVERSION) $(GARNAME)
	@cd $(PARTIALDIR); rm -rf $(GARNAME)-$(GARVERSION)
	@cd $(PARTIALDIR); mv $(GARNAME) $(GARNAME)-$(GARVERSION)
	@cd $(PARTIALDIR); tar -jc $(GARNAME)-$(GARVERSION) -f $(GARNAME)-$(GARVERSION).tar.bz2
	@cd $(PARTIALDIR); rm -rf $(GARNAME)-$(GARVERSION)
	@$(MAKECOOKIE)

checksum-$(GARNAME)-$(GARVERSION).tar.bz2:
	@$(MAKECOOKIE)

extract-$(CONFIGFILE):
	@cp $(DOWNLOADDIR)/$(CONFIGFILE)        $(WORKSRC)/settings.pro
	@sed -i 's%@PREFIX@%$(prefix)%'         $(WORKSRC)/settings.pro
	@sed -i 's%@DESTDIR@%$(DESTDIR)%'       $(WORKSRC)/settings.pro
	@sed -i 's%@INCLUDEDIR@%$(includedir)%' $(WORKSRC)/settings.pro
	@sed -i 's%@LIBDIR@%$(libdir)%'         $(WORKSRC)/settings.pro
	@sed -i 's%@CFLAGS@%$(CFLAGS)%'         $(WORKSRC)/settings.pro
	@$(MAKECOOKIE)

configure-custom: 
	@cd $(WORKSRC)/$(GARNAME) ; $(CONFIGURE_ENV) qmake $(GARNAME).pro
	@$(MAKECOOKIE)
