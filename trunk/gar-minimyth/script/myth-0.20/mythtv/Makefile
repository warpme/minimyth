GARNAME = mythtv
GARVERSION = $(GARVERSION_SHORT)-$(MYTHTV_SVN_VERSION)
CATEGORIES = $(CATEGORY)
MASTER_SITES = svn://svn.mythtv.org/svn/$(MYTHTV_SVN_BRANCH)/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES  =
PATCHFILES += \
	$(DISTNAME_SHORT)-changeset_19245.patch \
	$(DISTNAME_SHORT)-ticket-3035-20070207.patch \
	$(DISTNAME_SHORT)-ticket-4225-20071220.patch \
	$(DISTNAME_SHORT)-ticket-6105-20090110.patch \
	$(DISTNAME_SHORT)-dvdnav_shared.patch \
	$(DISTNAME_SHORT)-libdvdread_udf.patch \
	$(DISTNAME_SHORT)-avformat_asf_utf8.patch \
	$(DISTNAME_SHORT)-gcc_4.3.patch \
	$(DISTNAME_SHORT)-link_xvmc_lib.patch \
	$(DISTNAME_SHORT)-networkcontrol.patch \
	$(DISTNAME_SHORT)-eject.patch \
        $(DISTNAME_SHORT)-udevinfo.patch \
	$(DISTNAME_SHORT)-lm_sensors_detect.patch \
	$(DISTNAME_SHORT)-disable_drm_vsync.patch \
	$(DISTNAME_SHORT).patch.gar \
	$(DISTNAME_SHORT)-init.patch \
	$(DISTNAME_SHORT)-mythaudio.patch \
	$(DISTNAME_SHORT)-mythstream.patch \
	$(DISTNAME_SHORT)-minimyth.patch \
	$(DISTNAME_SHORT)-programid.patch \
	$(DISTNAME_SHORT)-fadeaway.patch \
	$(DISTNAME_SHORT)-alphapulse.patch \
	$(DISTNAME_SHORT)-startplayer_maxwait.patch \
	$(DISTNAME_SHORT)-preserve_timestamps.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = \
	lang/c++ \
	db/mysql \
	lib/alsa-lib \
	lib/faad2 \
	lib/freetype \
	lib/lame \
	lib/libdca \
	lib/zlib \
	qt/qt3 \
	system/lirc \
	xorg/xorg

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

PWD := $(shell pwd)

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile source

CONFIGURE_ARGS = \
	--compile-type=$(if $(filter yes,$(mm_DEBUG)),"debug","release") \
	--prefix="$(prefix)" \
	--libdir-name="lib" \
	--disable-ccache \
	--disable-distcc \
	--cross-prefix="$(compiler_prefix)" \
	--cc="gcc" \
	--extra-cflags="$(CFLAGS)" \
	--extra-cxxflags="$(CFLAGS)" \
	--cpu=$(GARCH) \
	--tune=$(GARCH) \
	--arch=$(GARCH_FAMILY) \
	--enable-proc-opt \
	--enable-mmx \
	--disable-iwmmxt \
	--disable-altivec \
	--enable-audio-oss \
	--enable-audio-alsa \
	--disable-audio-arts \
	--disable-audio-jack \
	--disable-valgrind \
	--enable-lirc \
	--enable-joystick-menu \
	--disable-firewire \
	--disable-freebox \
	--disable-dbox2 \
	--disable-hdhomerun \
	--disable-crciprec \
	--enable-v4l \
	--enable-ivtv \
	--enable-dvb \
	--dvb-path="$(DESTDIR)$(includedir)" \
	--enable-x11 \
	--x11-path="$(DESTDIR)$(includedir)" \
	--enable-xrandr \
	--enable-xv \
	--enable-xvmc \
	--enable-xvmc-pro \
	--disable-xvmc-opengl \
	--xvmc-lib=XvMCW \
	--disable-mac-accel \
	--enable-opengl-vsync \
	--disable-directfb \
	--disable-directx \
	--enable-faad \
	$(if $(filter -Os,$(CFLAGS)),--enable-small)

CONFIGURE_ENV = $(MYTHTV_CONFIGURE_ENV)
BUILD_ENV     = $(MYTHTV_BUILD_ENV)
INSTALL_ENV   = $(MYTHTV_INSTALL_ENV)

GAR_EXTRA_CONF += $(CATEGORY)/myth/package-api.mk
include ../../gar.mk

CFLAGS += -DUSE_ATI_PROPRIETARY_DRIVER_XVIDEO_HACK

svn//%/$(DISTNAME).tar.bz2:
	@$(call FETCH_SVN, http://$*, $(MYTHTV_SVN_VERSION), $(DISTNAME))
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

install-source:
	@rm -rf $(DESTDIR)$(MYTHTV_SOURCEDIR)
	@mkdir -p $(DESTDIR)$(MYTHTV_SOURCEDIR)
	@rm -rf $(DESTDIR)$(MYTHTV_SOURCEDIR)
	@ln -sf $(PWD)/$(WORKSRC) $(DESTDIR)$(MYTHTV_SOURCEDIR)
	@$(MAKECOOKIE)

post-install: post-install-mythtv-version
	@$(MAKECOOKIE)
