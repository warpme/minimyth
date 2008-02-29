GARNAME = myththemes
GARVERSION = 0.21
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
	$(DISTNAME).patch.gar \
	$(DISTNAME)-programid.patch \
	$(DISTNAME)-preserve_timestamps.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c $(CATEGORY)/mythtv

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

WORKSRC = $(strip $(if $(filter yes,$(MYTHTV_USE_RELEASE_TARBALL)), \
	$(WORKDIR)/$(DISTNAME), \
	$(WORKDIR)/$(DISTNAME)-$(MYTHTV_STABLE21_FIXES_VERSION)))

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

svn//%/$(DISTNAME)-$(MYTHTV_STABLE21_FIXES_VERSION).tar.bz2:
	$(call FETCH_SVN, http://$*, $(MYTHTV_STABLE21_FIXES_VERSION), $(DISTNAME)-$(MYTHTV_STABLE21_FIXES_VERSION))
	@$(MAKECOOKIE)

checksum-$(DISTNAME)-$(MYTHTV_STABLE21_FIXES_VERSION).tar.bz2:
	@$(MAKECOOKIE)

configure-%/mythtv:
	@cd $* ; $(CONFIGURE_ENV) qmake $(GARNAME).pro
	@$(MAKECOOKIE)

post-install:
	@install -d $(DESTDIR)$(versiondir) 
	@echo "$(GARVERSION) with fixes through SVN $(MYTHTV_STABLE21_FIXES_VERSION)" > $(DESTDIR)$(versiondir)/$(GARNAME)
	@$(MAKECOOKIE)
