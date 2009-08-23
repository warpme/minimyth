GARNAME = libva
GARVERSION = 0.30.4
CATEGORIES = X11
MASTER_SITES = http://www.splitted-desktop.com/~gbeauchesne/$(GARNAME)/
DISTFILES = $(GARNAME)_$(GARVERSION)-1+sds4.tar.gz
PATCHFILES = \
	101_fix_build_with_x11.patch \
	102_fix_make_dist.patch \
	103_drop_CFGLAGS_override.patch \
	104_fix_bitfields_types.patch \
	105_fix_vainfo.patch \
	106_fix_includes.patch \
	107_fix_dummy_drv_video_init.patch \
	108_drivers_path.patch \
	109_fix_tests.patch \
	110_conditional_drivers.patch \
	111_check_for_LIBVA_DRIVER_NAME_first.patch \
	112_fix_vaGetDriverName_DRI12.patch \
	113_drop_LIBDRM_DEPS_duplicate_check.patch \
	114_add_libXfixes_check.patch \
	115_fix_make_install.patch \
	116_add_VA_INVALID_ID.patch \
	117_fix_memory_leak.patch \
	201_change_SONAME.patch \
	202_split_libva.patch \
	204_version.patch \
	205_nvidia_drv_info.patch \
	206_drop_obsolete_fields.patch \
	207_nvidia_drv_version_fix.patch \
	208_fix_libva_x11_deps.patch \
	209_drop_libva_display_defs.patch \
	300_sds_version.patch \
	301_vdpau_h264.patch \
	302_vdpau_vc1.patch \
	303_xvba_h264.patch \
	304_vc1_skipped_p_frames.patch \
	310_VASliceParameterBufferBase.patch \
	320_move_vaPutSurface_flags_def.patch \
	321_libva_glx.patch \
	390_compat.patch
LICENSE = MIT

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c xorg/xorg

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
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
