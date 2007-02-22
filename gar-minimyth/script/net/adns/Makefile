GARNAME = adns
GARVERSION = 1.3
CATEGORIES = net
MASTER_SITES = ftp://ftp.gnu.org/gnu/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST)

INSTALL_OVERRIDE_DIRS = bindir includedir libdir

include ../../gar.mk

pre-configure:
	@cd $(WORKSRC) ; ACLOCAL=aclocal-1.9 AUTOMAKE=automake-1.9 autoreconf --verbose --install --force
	@$(MAKECOOKIE)
