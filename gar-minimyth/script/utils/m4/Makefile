GARNAME = m4
GARVERSION = 1.4.8
CATEGORIES = utils
MASTER_SITES = ftp://ftp.gnu.org/gnu/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST)

include ../../gar.mk
