GARNAME = make
GARVERSION = $(MAKE_VERSION)
CATEGORIES = devel
MASTER_SITES = ftp://ftp.gnu.org/gnu/make/
DISTFILES = $(GARNAME)-$(GARVERSION).tar.bz2
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
