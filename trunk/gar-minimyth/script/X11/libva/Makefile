GARNAME = libva
GARVERSION = 0.31.0
CATEGORIES = X11
MASTER_SITES = http://www.splitted-desktop.com/~gbeauchesne/$(GARNAME)/
DISTFILES = $(GARNAME)_$(GARVERSION)-1+sds5.tar.gz
PATCHFILES = \
	020_g45_nop_vaQueryDisplayAttributes.patch \
	021_g45_fix_vaQueryImageFormats.patch \
	022_g45_fix_driver_version.patch \
	023_g45_fix_associate_subpic_args.patch \
	102_attribute_visibility.patch \
	103_fix_vainfo_deps.patch \
	104_fix_libva_pkgconfig_deps.patch \
	105_dont_search_LIBGL_DRIVERS_PATH.patch \
	108_drivers_path.patch \
	203_fix_fglrx_detection.patch \
	300_sds_version.patch \
	320_move_vaPutSurface_flags_def.patch \
	321_libva_glx.base.patch \
	322_libva_glx.patch \
	390_compat.base.patch \
	391_compat.patch
LICENSE = MIT

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c xorg/xorg

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-glx \
	--enable-dummy-driver \
	--enable-i965-driver \
	--disable-static \
	--enable-shared \
	--with-drivers-path="$(libdir)/va" \
	--with-gnu-ld

include ../../gar.mk

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libva.la
	@rm -f $(DESTDIR)$(libdir)/libva-glx.la
	@rm -f $(DESTDIR)$(libdir)/libva-x11.la
	@rm -f $(DESTDIR)$(libdir)/va/dummy_drv_video.la
	@rm -f $(DESTDIR)$(libdir)/va/i965_drv_video.la
	@$(MAKECOOKIE)
