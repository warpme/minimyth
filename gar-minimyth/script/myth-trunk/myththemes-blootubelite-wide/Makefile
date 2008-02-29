GARNAME = blootubelite-wide
GARVERSION = $(mm_MYTH_TRUNK_VERSION)
CATEGORIES = $(CATEGORY)
MASTER_SITES = svn://svn.mythtv.org/svn/trunk/themes/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c $(CATEGORY)/mythtv

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

INSTALL_SCRIPTS  = custom

CONFIGURE_ENV = $(MYTHTV_CONFIGURE_ENV)
BUILD_ENV     = $(MYTHTV_BUILD_ENV)
INSTALL_ENV   = $(MYTHTV_INSTALL_ENV)

GAR_EXTRA_CONF += $(CATEGORY)/myth/package-api.mk
include ../../gar.mk

svn//%/$(DISTNAME).tar.bz2:
	@$(call FETCH_SVN, http://$*, $(GARVERSION), $(DISTNAME))
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

install-custom:
	@mkdir -p $(DESTDIR)$(datadir)/mythtv/themes
	@rm -rf $(DESTDIR)$(datadir)/mythtv/themes/$(GARNAME)
	@cp -af $(WORKSRC) $(DESTDIR)$(datadir)/mythtv/themes/$(GARNAME)
	@$(MAKECOOKIE)
