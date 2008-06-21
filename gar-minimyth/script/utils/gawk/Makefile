GARNAME = gawk
GARVERSION = 3.1.6
CATEGORIES = utils
MASTER_SITES = ftp://ftp.gnu.org/gnu/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = GPL3

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-rpath \
	--with-gnu-ld

include ../../gar.mk

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)
