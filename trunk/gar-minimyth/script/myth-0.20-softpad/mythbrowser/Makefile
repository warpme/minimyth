GARNAME = mythbrowser
GARVERSION = $(MYTHPLUGINS_VERSION)
CATEGORIES = $(CATEGORY)
SOURCEPKG = $(CATEGORY)/mythplugins
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = \
	lang/cxx \
	$(CATEGORY)/mythtv \
	kde/kdelibs

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = \
	$(MYTHPLUGINS_CONFIGURE_ARGS) \
	--enable-mythbrowser

CONFIGURE_ENV = $(MYTHTV_CONFIGURE_ENV)
BUILD_ENV     = $(MYTHTV_BUILD_ENV)
INSTALL_ENV   = $(MYTHTV_INSTALL_ENV)

GAR_EXTRA_CONF += $(CATEGORY)/myth/package-api.mk $(CATEGORY)/mythplugins/package-api.mk
include ../../gar.mk

# mythbrowser 0.20 fails to compile using the gold linker.
CXXFLAGS := $(filter-out -fuse-ld=gold -fuse-linker-plugin, $(XXCFLAGS))
LDFLAGS  := $(filter-out -fuse-ld=gold -fuse-linker-plugin, $(LDFLAGS))

post-install: post-install-mythtv-version
	@$(MAKECOOKIE)
