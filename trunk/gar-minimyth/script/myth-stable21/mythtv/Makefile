GARNAME = mythtv
GARVERSION = 0.21
CATEGORIES = $(CATEGORY)
MASTER_SITES = http://www.mythtv.org/mc/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-fixes-$(MYTHTV_STABLE21_FIXES_VERSION).patch $(DISTNAME)-gcc_4.3.patch $(DISTNAME)-openchrome.patch $(DISTNAME)-networkcontrol.patch $(DISTNAME)-eject.patch $(DISTNAME).patch.gar $(DISTNAME)-init.patch $(DISTNAME)-minimyth.patch $(DISTNAME)-programid.patch $(DISTNAME)-fadeaway.patch $(DISTNAME)-alphapulse.patch $(DISTNAME)-startplayer_maxwait.patch $(DISTNAME)-preserve_timestamps.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lang/c++ lib/alsa-lib lib/fftw3f lib/lame lib/zlib db/mysql lib/freetype xorg/xorg qt/qt system/lirc

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
	--target-os="linux" \
	--cc="gcc" \
	--extra-cflags="$(CFLAGS)" \
	--extra-cxxflags="$(CFLAGS)" \
	--arch=$(GARCH) \
	--tune=$(GARCH) \
	--cpu=$(GARCH) \
	--enable-proc-opt \
	--enable-mmx \
	--enable-audio-oss \
	--enable-audio-alsa \
	--disable-audio-arts \
	--disable-audio-jack \
	--disable-valgrind \
	--enable-lirc \
	--enable-joystick-menu \
	--disable-firewire \
	--disable-iptv \
	--disable-dbox2 \
	--disable-hdhomerun \
	--disable-v4l \
	--disable-ivtv \
	--disable-dvb \
	--dvb-path="/dev/null" \
	--enable-x11 \
	--x11-path="$(DESTDIR)$(includedir)" \
	--enable-xrandr \
	--enable-xv \
	--enable-xvmc \
	--enable-xvmcw \
	--enable-xvmc-pro \
	--disable-xvmc-opengl \
	--xvmc-lib=XvMCW \
	--enable-opengl-video \
	--disable-mac-accel \
	--enable-opengl-vsync \
	--disable-directfb \
	--disable-directx \
	--disable-mac-bundle \
	--without-bindings="perl,python"

CONFIGURE_ENV = $(MYTHTV_CONFIGURE_ENV)
BUILD_ENV     = $(MYTHTV_BUILD_ENV)
INSTALL_ENV   = $(MYTHTV_INSTALL_ENV)

GAR_EXTRA_CONF += $(CATEGORY)/myth/package-api.mk
include ../../gar.mk

CFLAGS += -DUSE_HACK_FOR_BROKEN_I420_SUPPORT_IN_DRIVER

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
	@echo "$(GARVERSION) with fixes through SVN $(MYTHTV_STABLE21_FIXES_VERSION)" > $(DESTDIR)$(versiondir)/$(GARNAME)
	@$(MAKECOOKIE)
