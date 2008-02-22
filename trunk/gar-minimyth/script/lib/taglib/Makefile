GARNAME = taglib
GARVERSION = 1.5
CATEGORIES = lib
MASTER_SITES = http://developer.kde.org/~wheeler/files/src/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME).patch.gar
LICENSE = LGPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/zlib

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--with-gnu-ld

include ../../gar.mk

post-install:
	@rm -f $(DESTDIR)$(libdir)/libtag.la
	@rm -f $(DESTDIR)$(libdir)/libtag_c.la
	@$(MAKECOOKIE)
