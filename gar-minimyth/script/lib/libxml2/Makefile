GARNAME = libxml2
GARVERSION = 2.7.2
CATEGORIES = lib
MASTER_SITES = ftp://xmlsoft.org/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = MIT/MIT_Modified

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/zlib

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-shared \
	--disable-static \
	--with-gnu-ld

include ../../gar.mk

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libxml2.la
	@sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'         $(DESTDIR)$(bindir)/xml2-config
	@sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g' $(DESTDIR)$(bindir)/xml2-config
	@sed -i 's%-L${libdir}%-L$(DESTDIR)${libdir}%g'           $(DESTDIR)$(libdir)/xml2Conf.sh
	@sed -i 's%-I${includedir}%-I$(DESTDIR)${includedir}%g'   $(DESTDIR)$(libdir)/xml2Conf.sh
	@$(MAKECOOKIE)
