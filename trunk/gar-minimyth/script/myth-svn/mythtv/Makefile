GARNAME = mythtv
GARVERSION = $(mm_MYTH_SVN_VERSION)
CATEGORIES = $(CATEGORY)
MASTER_SITES = svn://svn.mythtv.org/svn/trunk/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(GARNAME)-libdca.patch $(GARNAME)-eject.patch $(GARNAME).patch.gar $(GARNAME)-init.patch $(GARNAME)-mythstream.patch $(GARNAME)-minimyth.patch $(GARNAME)-programid.patch $(GARNAME)-fadeaway.patch $(GARNAME)-alphapulse.patch $(GARNAME)-preserve_timestamps.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lang/c++ kernel/kernel lib/alsa-lib lib/lame lib/libdca lib/zlib db/mysql lib/freetype xorg/xorg qt/qt system/lirc utils/lm_sensors

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

PWD := $(shell pwd)

CONFIGURE_SCRIPTS  = $(WORKSRC)/configure
CONFIGURE_SCRIPTS += $(WORKSRC)/mythtv
BUILD_SCRIPTS      = $(WORKSRC)/Makefile
INSTALL_SCRIPTS    = $(WORKSRC)/Makefile source

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
	--arch=$(GARCH) \
	--tune=$(GARCH) \
	--cpu=$(GARCH) \
	--disable-proc-opt \
	--enable-mmx \
	--enable-audio-oss \
	--enable-audio-alsa \
	--disable-audio-arts \
	--disable-audio-jack \
	--enable-libdts \
	--disable-valgrind \
	--enable-lirc \
	--enable-joystick-menu \
	--enable-lmsensors \
	--disable-firewire \
	--disable-iptv \
	--disable-dbox2 \
	--disable-hdhomerun \
	--disable-v4l \
	--disable-ivtv \
	--disable-dvb \
	--dvb-path="$(DESTDIR)$(LINUX_SOURCEDIR)/include" \
	--enable-x11 \
	--x11-path="$(DESTDIR)$(includedir)" \
	--enable-xrandr \
	--enable-xv \
	--enable-xvmc \
	--enable-xvmcw \
	--enable-xvmc-pro \
	--disable-xvmc-opengl \
	--xvmc-lib=XvMCW \
	--disable-opengl-video \
	--disable-mac-accel \
	--enable-opengl-vsync \
	--disable-directfb \
	--disable-directx \
	--disable-mac-bundle \
	--without-bindings="perl"

CONFIGURE_ENV = $(MYTHTV_CONFIGURE_ENV)
BUILD_ENV     = $(MYTHTV_BUILD_ENV)
INSTALL_ENV   = $(MYTHTV_INSTALL_ENV)

GAR_EXTRA_CONF += $(CATEGORY)/myth/package-api.mk kernel-$(mm_KERNEL_VERSION)/linux/package-api.mk
include ../../gar.mk

CFLAGS += -DUSE_HACK_FOR_BROKEN_I420_SUPPORT_IN_DRIVER

svn//%/$(DISTNAME).tar.bz2:
	@$(call FETCH_SVN, http://$*, $(GARVERSION), $(DISTNAME))
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

configure-%/mythtv:
	@cd $* ; $(CONFIGURE_ENV) qmake $(GARNAME).pro
	@$(MAKECOOKIE)

install-source:
	@rm -rf $(DESTDIR)$(MYTHTV_SOURCEDIR)
	@mkdir -p $(DESTDIR)$(MYTHTV_SOURCEDIR)
	@rm -rf $(DESTDIR)$(MYTHTV_SOURCEDIR)
	@ln -sf $(PWD)/$(WORKSRC) $(DESTDIR)$(MYTHTV_SOURCEDIR)
	@$(MAKECOOKIE)
