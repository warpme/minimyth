GARNAME = blootube-osd
GARVERSION = 0.21-$(MYTHTV_STABLE21_FIXES_VERSION)
CATEGORIES = $(CATEGORY)
MASTER_SITES = svn://svn.mythtv.org/svn/trunk/themes/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(GARNAME)-font.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c $(CATEGORY)/mythtv

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

BUILD_SCRIPTS   = custom
INSTALL_SCRIPTS = custom

CONFIGURE_ENV = $(MYTHTV_CONFIGURE_ENV)
BUILD_ENV     = $(MYTHTV_BUILD_ENV)
INSTALL_ENV   = $(MYTHTV_INSTALL_ENV)

GAR_EXTRA_CONF += $(CATEGORY)/myth/package-api.mk
include ../../gar.mk

svn//%/$(DISTNAME).tar.bz2:
	@$(call FETCH_SVN, http://$*, $(MYTHTV_STABLE21_FIXES_VERSION), $(DISTNAME))
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

build-custom:
	@rm -rf $(WORKSRC)/*.ttf
	@$(MAKECOOKIE)

install-custom:
	@mkdir -p $(DESTDIR)$(datadir)/mythtv/themes
	@rm -rf $(DESTDIR)$(datadir)/mythtv/themes/$(GARNAME)
	@cp -af $(WORKSRC) $(DESTDIR)$(datadir)/mythtv/themes/$(GARNAME)
	@$(MAKECOOKIE)
