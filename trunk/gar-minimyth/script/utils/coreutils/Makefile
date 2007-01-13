GARNAME = coreutils
GARVERSION = 5.2.1
CATEGORIES = utils
MASTER_SITES = ftp://ftp.gnu.org/gnu/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-sysinfo.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--with-gnu-ld

include ../../gar.mk
