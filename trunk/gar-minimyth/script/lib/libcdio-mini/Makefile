GARNAME = libcdio-mini
GARVERSION = $(LIBCDIO_VERSION)
CATEGORIES = lib
SOURCEPKG = lib/libcdio
LICENSE = LGPL2_1

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

WORKSRC = $(WORKDIR)/libcdio-$(GARVERSION)

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-cxx \
	--disable-cpp-progs \
	--enable-joliet \
	--disable-rpath \
	--enable-rock \
	--disable-cddb \
	--disable-vcd-info \
	--without-cd-drive \
	--without-cd-info \
	--with-cd-paranoia \
	--without-cdda-player \
	--without-cd-read \
	--without-iso-info \
	--without-iso-read \
	--with-gnu-ld

GAR_EXTRA_CONF += lib/libcdio/package-api.mk
include ../../gar.mk

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(MAKECOOKIE)

# For some reason, the Makefile.am has not be constructed to install
# libcdio++.pc, libiso9600++.pc or libudf.pc.
post-install:
	@rm -f $(DESTDIR)$(libdir)/libcdio.la
	@rm -f $(DESTDIR)$(libdir)/libcdio++.la
	@rm -f $(DESTDIR)$(libdir)/libcdio_cdda.la
	@rm -f $(DESTDIR)$(libdir)/libcdio_paranoia.la
	@rm -f $(DESTDIR)$(libdir)/libiso9660.la
	@rm -f $(DESTDIR)$(libdir)/libiso9660++.la
	@rm -f $(DESTDIR)$(libdir)/libudf.la
	@$(call CREATE_PKG_CONFIG_UNINSTALLED,$(libdir)/pkgconfig,libcdio)
	@#$(call CREATE_PKG_CONFIG_UNINSTALLED,$(libdir)/pkgconfig,libcdio++)
	@$(call CREATE_PKG_CONFIG_UNINSTALLED,$(libdir)/pkgconfig,libcdio_cdda)
	@$(call CREATE_PKG_CONFIG_UNINSTALLED,$(libdir)/pkgconfig,libcdio_paranoia)
	@$(call CREATE_PKG_CONFIG_UNINSTALLED,$(libdir)/pkgconfig,libiso9660)
	@#$(call CREATE_PKG_CONFIG_UNINSTALLED,$(libdir)/pkgconfig,libiso9660++)
	@#$(call CREATE_PKG_CONFIG_UNINSTALLED,$(libdir)/pkgconfig,libudf)
	@$(MAKECOOKIE)
