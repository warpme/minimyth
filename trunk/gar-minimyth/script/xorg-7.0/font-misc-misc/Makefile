GARNAME = font-misc-misc
GARVERSION = X11R$(XORG_VERSION)-1.0.0
CATEGORIES = xorg-7.0
MASTER_SITES = http://xorg.freedesktop.org/releases/X11R$(XORG_VERSION)/src/font/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/COPYING

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c xorg-7.0/font-util
BUILDDEPS = xorg-7.0/mkfontdir xorg-7.0/mkfontscale xorg-7.0/bdftopcf xorg-7.0/font-util

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	MAPFILES_PATH=$(PKG_CONFIG_PATH="$(build_DESTDIR)$(build_libdir)/pkgconfig" pkg-config --variable=mapdir fontutil)

GAR_EXTRA_CONF += xorg-7.0/xorg/package-api.mk
include ../../gar.mk

pre-configure:
	sed -i 's%^MAPFILES_PATH=.*%MAPFILES_PATH=$$(PKG_CONFIG_PATH="$(build_DESTDIR)$(build_libdir)/pkgconfig" pkg-config --variable=mapdir fontutil)%g' $(WORKSRC)/configure
	@sed -i 's%^ISO8859_2_BDF_FILES *=.*%%g'  $(WORKSRC)/Makefile.in
	@sed -i 's%^ISO8859_2_PCF_FILES *=.*%%g'  $(WORKSRC)/Makefile.in
	@sed -i 's%^ISO8859_3_BDF_FILES *=.*%%g'  $(WORKSRC)/Makefile.in
	@sed -i 's%^ISO8859_3_PCF_FILES *=.*%%g'  $(WORKSRC)/Makefile.in
	@sed -i 's%^ISO8859_4_BDF_FILES *=.*%%g'  $(WORKSRC)/Makefile.in
	@sed -i 's%^ISO8859_4_PCF_FILES *=.*%%g'  $(WORKSRC)/Makefile.in
	@sed -i 's%^ISO8859_5_BDF_FILES *=.*%%g'  $(WORKSRC)/Makefile.in
	@sed -i 's%^ISO8859_5_PCF_FILES *=.*%%g'  $(WORKSRC)/Makefile.in
	@sed -i 's%^ISO8859_6_BDF_FILES *=.*%%g'  $(WORKSRC)/Makefile.in
	@sed -i 's%^ISO8859_6_PCF_FILES *=.*%%g'  $(WORKSRC)/Makefile.in
	@sed -i 's%^ISO8859_7_BDF_FILES *=.*%%g'  $(WORKSRC)/Makefile.in
	@sed -i 's%^ISO8859_7_PCF_FILES *=.*%%g'  $(WORKSRC)/Makefile.in
	@sed -i 's%^ISO8859_8_BDF_FILES *=.*%%g'  $(WORKSRC)/Makefile.in
	@sed -i 's%^ISO8859_8_PCF_FILES *=.*%%g'  $(WORKSRC)/Makefile.in
	@sed -i 's%^ISO8859_9_BDF_FILES *=.*%%g'  $(WORKSRC)/Makefile.in
	@sed -i 's%^ISO8859_9_PCF_FILES *=.*%%g'  $(WORKSRC)/Makefile.in
	@sed -i 's%^ISO8859_10_BDF_FILES *=.*%%g' $(WORKSRC)/Makefile.in
	@sed -i 's%^ISO8859_10_PCF_FILES *=.*%%g' $(WORKSRC)/Makefile.in
	@sed -i 's%^ISO8859_11_BDF_FILES *=.*%%g' $(WORKSRC)/Makefile.in
	@sed -i 's%^ISO8859_11_PCF_FILES *=.*%%g' $(WORKSRC)/Makefile.in
	@sed -i 's%^ISO8859_12_BDF_FILES *=.*%%g' $(WORKSRC)/Makefile.in
	@sed -i 's%^ISO8859_12_PCF_FILES *=.*%%g' $(WORKSRC)/Makefile.in
	@sed -i 's%^ISO8859_13_BDF_FILES *=.*%%g' $(WORKSRC)/Makefile.in
	@sed -i 's%^ISO8859_13_PCF_FILES *=.*%%g' $(WORKSRC)/Makefile.in
	@sed -i 's%^ISO8859_14_BDF_FILES *=.*%%g' $(WORKSRC)/Makefile.in
	@sed -i 's%^ISO8859_14_PCF_FILES *=.*%%g' $(WORKSRC)/Makefile.in
	@sed -i 's%^ISO8859_15_BDF_FILES *=.*%%g' $(WORKSRC)/Makefile.in
	@sed -i 's%^ISO8859_15_PCF_FILES *=.*%%g' $(WORKSRC)/Makefile.in
	@sed -i 's%^ISO8859_16_BDF_FILES *=.*%%g' $(WORKSRC)/Makefile.in
	@sed -i 's%^ISO8859_16_PCF_FILES *=.*%%g' $(WORKSRC)/Makefile.in
	@sed -i 's%^KOI8_R_BDF_FILES *=.*%%g'     $(WORKSRC)/Makefile.in
	@sed -i 's%^KOI8_R_PCF_FILES *=.*%%g'     $(WORKSRC)/Makefile.in
	@sed -i 's%^JISX0201_BDF_FILES *=.*%%g'   $(WORKSRC)/Makefile.in
	@sed -i 's%^JISX0201_PCF_FILES *=.*%%g'   $(WORKSRC)/Makefile.in
	@$(MAKECOOKIE)
