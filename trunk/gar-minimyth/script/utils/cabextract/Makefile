GARNAME = cabextract
GARVERSION = 1.2
CATEGORIES = utils
MASTER_SITES = http://www.kyz.uklinux.net/downloads/
DISTFILES = $(DISTNAME).tar.gz
LICENSE =

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST)

include ../../gar.mk
