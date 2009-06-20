GARNAME = libva
GARVERSION = 0.29
CATEGORIES = X11
MASTER_SITES  = http://www.splitted-desktop.com/~gbeauchesne/$(GARNAME)/
MASTER_SITES += http://www.splitted-desktop.com/~gbeauchesne/$(GARNAME)/patches/
DISTFILES = $(GARNAME)_0.29-2+sds12.tar.gz
PATCHFILES = \
	102_fix_make_dist.patch \
	103_fix_includes.patch \
	104_fix_anon_unions.patch \
	105_libdrm_headers_check.patch \
	106_libva_includedir.patch \
	107_cosmetics.patch \
	108_drivers_path.patch \
	109_VA_FOURCC.patch \
	201_change_SONAME.patch \
	202_split_libva.patch \
	204_version.patch \
	205_nvidia_drv_info.patch \
	300_sds_version.patch \
	301_vdpau_h264.patch \
	302_vdpau_vc1.patch \
	303_xvba_h264.patch \
	304_vc1_skipped_p_frames.patch \
	310_VASliceParameterBufferBase.patch \
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
	@rm -f $(DESTDIR)$(libdir)/libva-x11.la
	@rm -f $(DESTDIR)$(libdir)/va/dummy_drv_video.la
	@$(MAKECOOKIE)
