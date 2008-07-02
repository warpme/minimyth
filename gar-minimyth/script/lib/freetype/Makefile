GARNAME = freetype
GARVERSION = 2.3.7
CATEGORIES = lib
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME).patch.gar
LICENSE = FTL/GPL2
FTL_LICENSE_TEXT = $(WORKSRC)/docs/FTL.TXT

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/zlib

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--with-gnu-ld

CONFIGURE_ENV  = \
	CC_BUILD="$(build_CC) $(build_CFLAGS)"

include ../../gar.mk

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libfreetype.la
	@ln -sf freetype2/freetype $(DESTDIR)$(includedir)/freetype
	@$(MAKECOOKIE)
