GARNAME = jpeg
GARVERSION = 6b
CATEGORIES = lib
MASTER_SITES = ftp://ftp.uu.net/graphics/$(GARNAME)/
DISTFILES = jpegsrc.v$(GARVERSION).tar.gz
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
	--x-includes=$(DESTDIR)$(x11includedir) \
	--x-libraries=$(DESTDIR)$(x11libdir) \
	--enable-static \
	--enable-shared

INSTALL_OVERRIDE_DIRS = prefix exec_prefix

include ../../gar.mk

post-patch:
	@# Libtool wants to hardcode library paths. This stops that unwanted behavior.
	@sed -i 's%^hardcode_libdir_flag_spec=.*%hardcode_libdir_flag_spec=%' $(WORKSRC)/ltconfig
	@# Libtool wants to modify the library run path. This stops that unwanted behavior.
	@sed -i 's%^runpath_var=.*%runpath_var=%' $(WORKSRC)/ltconfig
	@$(MAKECOOKIE)

install-custom:
	@$(INSTALL_ENV) $(MAKE) DESTDIR=$(DESTDIR) $(foreach TTT,$(INSTALL_OVERRIDE_DIRS),$(TTT)="$(DESTDIR)$($(TTT))") -C $(WORKSRC) $(INSTALL_ARGS) install install-lib
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libjpeg.la
	@$(MAKECOOKIE)
