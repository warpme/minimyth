GARNAME = freetype
GARVERSION = 2.1.9
CATEGORIES = X11
MASTER_SITES = http://unc.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = gar-base.diff
LICENSE = FTL/GPL2
FTL_LICENSE_TEXT = $(WORKSRC)/docs/FTL.txt

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/zlib

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST)

include ../../gar.mk

post-install:
	@rm -f $(DESTDIR)$(libdir)/libfreetype.la
	@ln -s freetype2/freetype $(DESTDIR)$(includedir)/freetype
	@sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'         $(DESTDIR)$(libdir)/pkgconfig/freetype2.pc
	@sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g' $(DESTDIR)$(libdir)/pkgconfig/freetype2.pc
	@$(MAKECOOKIE)
