GARNAME = mythplugins
GARVERSION = $(MYTHPLUGINS_VERSION)
CATEGORIES = $(CATEGORY)
MASTER_SITES = svn://svn.mythtv.org/svn/$(MYTHTV_SVN_BRANCH)/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES  =
PATCHFILES += \
	$(DISTNAME_SHORT)-mythgallery_programs_libs_pro.patch \
	$(DISTNAME_SHORT)-mythmusic_cdio.patch \
	$(DISTNAME_SHORT)-mythmusic_fftw3.patch \
	$(DISTNAME_SHORT).patch.gar \
	$(DISTNAME_SHORT)-init.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = \
	lang/c++ \
	$(CATEGORY)/mythtv

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

GAR_EXTRA_CONF += $(CATEGORY)/myth/package-api.mk
include ../../gar.mk

svn//%/$(DISTNAME).tar.bz2:
	@$(call FETCH_SVN, http://$*, $(MYTHTV_SVN_VERSION), $(DISTNAME))
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

post-install:
	@rm -rf $(DESTDIR)$(versiondir)/$(GARNAME)
	@rm -rf $(DESTDIR)$(licensedir)/$(GARNAME)
	@$(MAKECOOKIE)
