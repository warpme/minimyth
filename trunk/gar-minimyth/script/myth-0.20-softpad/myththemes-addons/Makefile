GARNAME = myththemes-addons
GARVERSION = $(GARVERSION_SHORT)-14914
CATEGORIES = $(CATEGORY)
MASTER_SITES = svn://svn.mythtv.org/svn/trunk/themes/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES  =
PATCHFILES += \
	$(DISTNAME_SHORT)-qmake.patch \
	$(DISTNAME_SHORT).patch.gar \
	$(DISTNAME_SHORT)-font.patch \
	$(DISTNAME_SHORT)-fadeaway.patch \
	$(DISTNAME_SHORT)-preserve_timestamps.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = \
	lang/c++ \
	$(CATEGORY)/mythtv

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = \
	--prefix="$(prefix)"

CONFIGURE_ENV = $(MYTHTV_CONFIGURE_ENV)
BUILD_ENV     = $(MYTHTV_BUILD_ENV)
INSTALL_ENV   = $(MYTHTV_INSTALL_ENV)

GAR_EXTRA_CONF += $(CATEGORY)/myth/package-api.mk
include ../../gar.mk

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

pre-configure:
	@echo "themes.files  ="                   >> $(WORKSRC)/themes.pro
	@echo "themes.files += blootube-osd"      >> $(WORKSRC)/themes.pro
	@echo "themes.files += blootubelite-wide" >> $(WORKSRC)/themes.pro

post-install: post-install-mythtv-version
	@$(MAKECOOKIE)
