GARNAME = libxslt
GARVERSION = 1.1.24
CATEGORIES = lib
MASTER_SITES = ftp://xmlsoft.org/libxml2/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = MIT_Modified

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/libxml2 lib/zlib

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--with-gnu-ld \
	--with-libxml-prefix=$(DESTDIR)$(prefix) \
	--with-libxml-include-prefix=$(DESTDIR)$(includedir) \
	--with-libxml-libs-prefix=$(DESTDIR)$(libdir)

include ../../gar.mk

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libexslt.la
	@rm -f $(DESTDIR)$(libdir)/libxslt.la
	@sed -i 's%-L$(DESTDIR)$(libdir)%-L$${libdir}%g' $(DESTDIR)$(libdir)/pkgconfig/libexslt.pc
	@sed -i 's%-L$(DESTDIR)$(libdir)%-L$${libdir}%g' $(DESTDIR)$(libdir)/pkgconfig/libxslt.pc
	@sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'         $(DESTDIR)$(bindir)/xslt-config
	@sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g' $(DESTDIR)$(bindir)/xslt-config
	@sed -i 's%-L${libdir}%-L$(DESTDIR)${libdir}%g'           $(DESTDIR)$(libdir)/xsltConf.sh
	@sed -i 's%-I${includedir}%-I$(DESTDIR)${includedir}%g'   $(DESTDIR)$(libdir)/xsltConf.sh
	@$(MAKECOOKIE)
