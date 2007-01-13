GARNAME = libpng
GARVERSION = 1.2.8
CATEGORIES = lib
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME)-config.tar.gz
PATCHFILES = $(DISTNAME)-DESTDIR.patch
LICENSE = png
png_LICENSE_TEXT = $(WORKSRC)/LICENSE

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/zlib

WORKSRC = $(WORKDIR)/$(DISTNAME)-config

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--with-gnu-ld \
	--without-x

INSTALL_OVERRIDE_DIRS = prefix exec_prefix

include ../../gar.mk

post-install:
	rm -f $(DESTDIR)$(libdir)/libpng12.la
	rm -f $(DESTDIR)$(libdir)/libpng.la
	$(MAKECOOKIE)
