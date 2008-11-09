GARNAME = jpeg
GARVERSION = 6b
CATEGORIES = lib
MASTER_SITES = ftp://ftp.uu.net/graphics/$(GARNAME)/
DISTFILES = jpegsrc.v$(GARVERSION).tar.gz
PATCHFILES = $(DISTNAME)-jconfig_h.patch
LICENSE = jpeg
jpeg_LICENSE_TEXT = $(WORKSRC)/README
DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = custom

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-static \
	--enable-shared

INSTALL_OVERRIDE_DIRS = prefix exec_prefix bindir libdir includedir mandir
  
include ../../gar.mk

mandir := $(mandir)/man1

pre-configure:
	@cp -f $(build_DESTDIR)$(build_datadir)/libtool/config/config.sub $(WORKSRC)
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(call FIX_LIBTOOL,$(WORKSRC)/ltconfig)
	@sed -i 's%^host=.*%host=$(GARHOST)%' $(WORKSRC)/ltconfig
	@$(MAKECOOKIE)

install-custom:
	@$(INSTALL_ENV) $(MAKE) DESTDIR=$(DESTDIR) $(foreach TTT,$(INSTALL_OVERRIDE_DIRS),$(TTT)="$(DESTDIR)$($(TTT))") -C $(WORKSRC) $(INSTALL_ARGS) install install-lib
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libjpeg.la
	@$(MAKECOOKIE)
