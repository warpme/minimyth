GARNAME = mythnetvision
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
	python/python \
	python/python-pycurl \
	python/python-lxml \
	python/python-oauth
BUILDDEPS = \
	python/python \
	python/python-pycurl \
	python/python-lxml \
	python/python-oauth

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = \
	$(MYTHPLUGINS_CONFIGURE_ARGS) \
	--enable-mythnetvision

CONFIGURE_ENV = $(MYTHTV_CONFIGURE_ENV) PYTHONXCPREFIX=$(DESTDIR)$(prefix)
BUILD_ENV     = $(MYTHTV_BUILD_ENV)
INSTALL_ENV   = $(MYTHTV_INSTALL_ENV)

GAR_EXTRA_CONF += $(CATEGORY)/myth/package-api.mk $(CATEGORY)/mythplugins/package-api.mk
include ../../gar.mk

post-install: post-install-mythtv-version
	@$(MAKECOOKIE)
