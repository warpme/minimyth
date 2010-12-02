GARNAME = myththemes-old
GARVERSION = $(MYTHTV_VERSION)
CATEGORIES = $(CATEGORY)
SOURCEPKG = $(CATEGORY)/mythtv
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = \
	lang/cxx \
	$(CATEGORY)/mythtv

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

WORKSRC = $(WORKDIR)/mythtv-$(MYTHTV_VERSION)

CONFIGURE_SCRIPTS = $(WORKSRC)/oldthemes/configure
INSTALL_SCRIPTS   = $(WORKSRC)/oldthemes/Makefile

CONFIGURE_ARGS = \
	--prefix="$(prefix)" \
	--sysroot="$(DESTDIR)$(rootdir)" \
	--qmake="$(DESTDIR)$(qt4bindir)/qmake"

CONFIGURE_ENV = $(MYTHTV_CONFIGURE_ENV)
BUILD_ENV     = $(MYTHTV_BUILD_ENV)
INSTALL_ENV   = $(MYTHTV_INSTALL_ENV)

GAR_EXTRA_CONF += $(CATEGORY)/mythtv/package-api.mk
include ../../gar.mk

post-install: post-install-mythtv-version
	@$(MAKECOOKIE)
