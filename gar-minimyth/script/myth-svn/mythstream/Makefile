GARNAME = mythstream
GARVERSION = v0.18_1
CATEGORIES = $(CATEGORY)
MASTER_SITES = http://home.kabelfoon.nl/~moongies/sw9vc4htz2/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES  = $(DISTNAME)-gcc_4.3.patch $(DISTNAME)-mythpopupbox_delete.patch $(DISTNAME)-harvester_cpp.patch $(DISTNAME).patch.gar
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c qt/qt $(CATEGORY)/mythtv lib/fftw

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

WORKSRC = $(WORKDIR)/$(GARNAME)-0.18_1

CONFIGURE_SCRIPTS = $(WORKSRC)/mythtv
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ENV = $(MYTHTV_CONFIGURE_ENV)
BUILD_ENV     = $(MYTHTV_BUILD_ENV)
INSTALL_ENV   = $(MYTHTV_INSTALL_ENV)

GAR_EXTRA_CONF += $(CATEGORY)/myth/package-api.mk
include ../../gar.mk

configure-%/mythtv:
	@cd $* ; $(CONFIGURE_ENV) qmake $(GARNAME).pro
	@$(MAKECOOKIE)
