GARNAME = libcdaudio
GARVERSION = 0.99.12
CATEGORIES = lib
MASTER_SITES = http://voxel.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(GARNAME)-$(GARVERSION).tar.gz
PATCHFILES = $(GARNAME)-$(GARVERSION)-DESTDIR.patch
LICENSE = GPL2

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
	@rm -f $(DESTDIR)$(libdir)/libcdaudio.la
	@$(MAKECOOKIE)
