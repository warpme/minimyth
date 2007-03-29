GARNAME = mythtv
GARVERSION = 0.20
CATEGORIES = $(CATEGORY)
MASTER_SITES = http://www.mythtv.org/mc/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-fixes-$(MYTHTV_STABLE20_FIXES_VERSION).patch $(DISTNAME)-ticket-3035-20070207.patch $(DISTNAME)-avformat_asf_utf8.patch $(DISTNAME)-eject.patch $(DISTNAME)-softpad.patch $(DISTNAME).patch.gar $(DISTNAME)-init.patch $(DISTNAME)-mythaudio.patch $(DISTNAME)-mythstream.patch $(DISTNAME)-minimyth.patch $(DISTNAME)-programid.patch $(DISTNAME)-fadeaway.patch $(DISTNAME)-preserve_timestamps.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lang/c++ kernel/kernel lib/alsa-lib lib/lame lib/libdts lib/zlib db/mysql lib/freetype xorg/xorg qt/qt system/lirc utils/lm_sensors

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
	--cpu=$(GARCH) \
	--tune=$(GARCH) \
	--arch=$(GARCH) \
	--enable-proc-opt \
	--enable-mmx \
	--disable-iwmmxt \
	--disable-altivec \
	--enable-audio-oss \
	--enable-audio-alsa \
	--disable-audio-arts \
	--disable-audio-jack \
	$(if $(filter yes,$(mm_DEBUG)),--enable-valgrind,--disable-valgrind) \
	--enable-lirc \
	--enable-joystick-menu \
	--disable-firewire \
	--disable-freebox \
	--disable-dbox2 \
	--disable-hdhomerun \
	--disable-crciprec \
	--disable-v4l \
	--disable-ivtv \
	--disable-dvb \
	--dvb-path="$(DESTDIR)$(LINUX_SOURCEDIR)/include" \
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
	--disable-directx

CONFIGURE_ENV = \
	DESTDIR="$(DESTDIR)" \
	QTDIR="$(DESTDIR)$(qtprefix)" \
	QMAKESPEC="default" \
	OPTFLAGS="$(CFLAGS)"
BUILD_ENV     = \
	DESTDIR="$(DESTDIR)" \
	QTDIR="$(DESTDIR)$(qtprefix)" \
	QMAKESPEC="default" \
	OPTFLAGS="$(CFLAGS)"
INSTALL_ENV   = \
	DESTDIR="$(DESTDIR)" \
	QTDIR="$(DESTDIR)$(qtprefix)" \
	QMAKESPEC="default" \
	OPTFLAGS="$(CFLAGS)" \
	INSTALL_ROOT="$(DESTDIR)"

GAR_EXTRA_CONF += kernel-$(mm_KERNEL_VERSION)/linux/package-api.mk
include ../../gar.mk

CFLAGS += -DUSE_ATI_PROPRIETARY_DRIVER_XVIDEO_HACK

configure-%/mythtv:
	@cd $* ; $(CONFIGURE_ENV) qmake $(GARNAME).pro
	@$(MAKECOOKIE)

install-source:
	@rm -rf $(DESTDIR)$(MYTHTV_SOURCEDIR)
	@mkdir -p $(DESTDIR)$(MYTHTV_SOURCEDIR)
	@rm -rf $(DESTDIR)$(MYTHTV_SOURCEDIR)
	@ln -sf $(PWD)/$(WORKSRC) $(DESTDIR)$(MYTHTV_SOURCEDIR)
	@$(MAKECOOKIE)

post-install:
	@install -d $(DESTDIR)$(versiondir) 
	@echo "$(GARVERSION) with fixes through SVN $(MYTHTV_STABLE20_FIXES_VERSION)" > $(DESTDIR)$(versiondir)/$(GARNAME)
	@$(MAKECOOKIE)
