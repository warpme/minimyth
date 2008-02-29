GARNAME = mythplugins
GARVERSION = $(MYTHPLUGINS_VERSION)
CATEGORIES = $(CATEGORY)
MASTER_SITES = $(strip $(if $(filter yes,$(MYTHTV_USE_RELEASE_TARBALL)), \
	http://www.mythtv.org/mc/, \
	svn://svn.mythtv.org/svn/branches/release-0-21-fixes/$(GARNAME)/))
DISTFILES = $(strip $(if $(filter yes,$(MYTHTV_USE_RELEASE_TARBALL)), \
	$(DISTNAME).tar.bz2, \
	$(DISTNAME)-$(MYTHTV_STABLE21_FIXES_VERSION).tar.bz2))
PATCHFILES  =
PATCHFILES += $(strip $(if $(filter yes,$(MYTHTV_USE_RELEASE_TARBALL)), \
	$(DISTNAME)-fixes-$(MYTHTV_STABLE21_FIXES_VERSION).patch, \
	))
PATCHFILES += \
	$(DISTNAME)-gcc_4.3.patch \
	$(DISTNAME)-mythmusic_cdio.patch \
	$(DISTNAME).patch.gar \
	$(DISTNAME)-init.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS  = lang/c $(CATEGORY)/mythtv

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

GAR_EXTRA_CONF += $(CATEGORY)/myth/package-api.mk
include ../../gar.mk

svn//%/$(DISTNAME)-$(MYTHTV_STABLE21_FIXES_VERSION).tar.bz2:
	$(call FETCH_SVN, http://$*, $(MYTHTV_STABLE21_FIXES_VERSION), $(DISTNAME)-$(MYTHTV_STABLE21_FIXES_VERSION))
	@$(MAKECOOKIE)

checksum-$(DISTNAME)-$(MYTHTV_STABLE21_FIXES_VERSION).tar.bz2:
	@$(MAKECOOKIE)

post-install:
	@rm -rf $(DESTDIR)$(versiondir)/$(GARNAME)
	@rm -rf $(DESTDIR)$(licensedir)/$(GARNAME)
	@$(MAKECOOKIE)
