GARNAME = libva
GARVERSION = 0.31.0
CATEGORIES = X11
MASTER_SITES = http://www.splitted-desktop.com/~gbeauchesne/$(GARNAME)/
DISTFILES = $(GARNAME)_$(GARVERSION)-1+sds3.tar.gz
PATCHFILES = \
	001_mpeg2_slice_horizontal_position.patch \
	102_attribute_visibility.patch \
	108_drivers_path.patch \
	201_drop_assert_in_isDRI1Connected.patch \
	202_cleanup_nvidia_detection.patch \
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
