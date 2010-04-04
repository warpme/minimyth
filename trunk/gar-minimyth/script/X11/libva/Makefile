GARNAME = libva
GARVERSION = 0.31.0
CATEGORIES = X11
MASTER_SITES = http://www.splitted-desktop.com/~gbeauchesne/$(GARNAME)/
DISTFILES = $(GARNAME)_$(GARVERSION)-1+sds12.tar.gz
PATCHFILES = \
	032_g45_fix_subpic_formats.patch \
	033_g45_add_rgba_subpic.patch \
	034_g45_fix_return_for_unimpl.patch \
	035_g45_add_yv12_image_format.patch \
	036_g45_add_vaGetImage.patch \
	037_g45_add_vaPutImage.patch \
	038_g45_vaPutSurface_cliprects.patch \
	039_g45_add_vaDeriveImage.patch \
	040_g45_add_i420_image_format.patch \
	102_attribute_visibility.patch \
	103_fix_vainfo_deps.patch \
	104_fix_libva_pkgconfig_deps.patch \
	105_dont_search_LIBGL_DRIVERS_PATH.patch \
	108_drivers_path.patch \
	201_libva_LIBVA_DRIVER_NAME.patch \
	202_check_crystalhd.patch \
	203_fix_fglrx_detection.patch \
	204_check_ATIFGLEXTENSION.patch \
	300_sds_version.patch \
	321_libva_glx.base.patch \
	322_libva_glx.patch \
	390_compat.base.patch \
	391_compat.patch \
	392_compat.dso.patch
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
	@rm -f $(DESTDIR)$(libdir)/libva-compat.la
	@rm -f $(DESTDIR)$(libdir)/libva-glx.la
	@rm -f $(DESTDIR)$(libdir)/libva-x11.la
	@rm -f $(DESTDIR)$(libdir)/va/dummy_drv_video.la
	@rm -f $(DESTDIR)$(libdir)/va/i965_drv_video.la
	@$(MAKECOOKIE)
