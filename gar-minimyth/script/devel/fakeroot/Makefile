GARNAME = fakeroot
GARVERSION = 1.9.4
CATEGORIES = devel
MASTER_SITES = http://ftp.debian.org/debian/pool/main/f/$(GARNAME)/
DISTFILES = $(GARNAME)_$(GARVERSION).tar.gz
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
BUILD_ARGS     = \
	SUBDIRS="scripts test"
INSTALL_ARGS   = \
	SUBDIRS="scripts test"

include ../../gar.mk

post-install:
	@rm -rf $(DESTDIR)$(libdir)/libfakeroot.la
	@$(MAKECOOKIE)
