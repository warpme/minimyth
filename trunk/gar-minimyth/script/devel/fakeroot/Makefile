GARNAME = fakeroot
GARVERSION = 1.11.3
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
	--enable-shared \
	--disable-static \
	--with-gnu-ld
BUILD_ARGS     = \
	SUBDIRS="scripts test"
INSTALL_ARGS   = \
	SUBDIRS="scripts test"

include ../../gar.mk

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -rf $(DESTDIR)$(libdir)/libfakeroot.la
	@$(MAKECOOKIE)
