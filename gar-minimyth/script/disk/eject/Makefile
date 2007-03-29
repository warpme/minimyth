GARNAME = eject
GARVERSION = 2.1.5
CATEGORIES = disk
MASTER_SITES  = http://ca.geocities.com/jefftranter@rogers.com/
MASTER_SITES += http://www.ibiblio.org/pub/Linux/utils/disk-management/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-opendevice.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

WORKSRC = $(WORKDIR)/$(GARNAME)

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST)

include ../../gar.mk
