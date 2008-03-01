GARNAME = myththemes-addons
GARVERSION = $(GARVERSION_SHORT)-$(MYTHTV_SVN_VERSION)
CATEGORIES = $(CATEGORY)
MASTER_SITES = svn://svn.mythtv.org/svn/$(MYTHTV_SVN_BRANCH)/themes/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES  =
PATCHFILES += \
	$(DISTNAME_SHORT).patch.gar \
	$(DISTNAME_SHORT)-font.patch \
	$(DISTNAME_SHORT)-preserve_timestamps.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

x_DEPENDS = lang/c $(CATEGORY)/mythtv

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

CONFIGURE_SCRIPTS  = $(WORKSRC)/configure
CONFIGURE_SCRIPTS += $(WORKSRC)/mythtv
INSTALL_SCRIPTS    = $(WORKSRC)/Makefile

CONFIGURE_ARGS = \
	--prefix="$(prefix)"

CONFIGURE_ENV = $(MYTHTV_CONFIGURE_ENV)
BUILD_ENV     = $(MYTHTV_BUILD_ENV)
INSTALL_ENV   = $(MYTHTV_INSTALL_ENV)

GAR_EXTRA_CONF += $(CATEGORY)/myth/package-api.mk
include ../../gar.mk

svn//%/$(DISTNAME).tar.bz2:
	@$(call FETCH_SVN, http://$*, $(MYTHTV_SVN_VERSION), $(DISTNAME))
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

pre-configure:
	@echo "themes.files  ="                   >> $(WORKSRC)/themes.pro
	@echo "themes.files += blootube-osd"      >> $(WORKSRC)/themes.pro
	@echo "themes.files += blootubelite-wide" >> $(WORKSRC)/themes.pro

configure-%/mythtv:
	@cd $* ; $(CONFIGURE_ENV) qmake themes.pro
	@$(MAKECOOKIE)

post-install:
	@install -d $(DESTDIR)$(versiondir) 
	@echo "$(GARVERSION_SHORT) with fixes through SVN $(MYTHTV_SVN_VERSION)" > $(DESTDIR)$(versiondir)/$(GARNAME)
	@$(MAKECOOKIE)
