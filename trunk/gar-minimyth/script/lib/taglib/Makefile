GARNAME = taglib
GARVERSION = 1.6.1
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

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libtag.la
	@rm -f $(DESTDIR)$(libdir)/libtag_c.la
	@rm -f $(DESTDIR)$(bindir)-config/taglib-config
	@rm -f $(DESTDIR)$(bindir)-config/$(compiler_prefix)taglib-config
	@mkdir -p $(DESTDIR)$(bindir)-config
	@mv $(DESTDIR)$(bindir)/taglib-config $(DESTDIR)$(bindir)-config/taglib-config
	@$(if $(compiler_prefix), ln -s taglib-config $(DESTDIR)$(bindir)-config/$(compiler_prefix)taglib-config)
	@$(MAKECOOKIE)
