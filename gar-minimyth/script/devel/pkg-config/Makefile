GARNAME = pkg-config
GARVERSION = 0.21
CATEGORIES = devel
MASTER_SITES = http://pkgconfig.freedesktop.org/releases/
DISTFILES = $(DISTNAME).tar.gz 
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
