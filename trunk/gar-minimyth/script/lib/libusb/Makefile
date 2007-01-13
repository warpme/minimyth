GARNAME = libusb
GARVERSION = 0.1.8
CATEGORIES = lib
MASTER_SITES = http://voxel.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(GARNAME)-$(GARVERSION).tar.gz
PATCHFILES = $(GARNAME)-$(GARVERSION)-DESTDIR.patch
LICENSE = LGPL2_1

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

PATCHDIR = $(WORKSRC)

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST)

include ../../gar.mk

post-install:
	rm -f $(DESTDIR)$(libdir)/libusb.la
	$(MAKECOOKIE)
