GARNAME = mythtv
GARVERSION = 0.19
CATEGORIES = $(CATEGORY)
MASTER_SITES = http://www.mythtv.org/mc/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-fixes-$(MYTHTV_STABLE19_FIXES_VERSION).patch $(DISTNAME)-changeset-11610.patch $(DISTNAME)-avformat_asf_utf8.patch $(DISTNAME)-lcdproc.patch $(DISTNAME)-xvmc_surfaces.patch $(DISTNAME)-pmount.patch $(DISTNAME)-eject.patch $(DISTNAME).patch.gar $(DISTNAME)-init.patch $(DISTNAME)-mythstream.patch $(DISTNAME)-minimyth.patch $(DISTNAME)-programid.patch $(DISTNAME)-fadeaway.patch $(DISTNAME)-preserve_timestamps.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lang/c++ kernel/kernel lib/alsa-lib lib/lame lib/libdca lib/libdvdnav lib/zlib db/mysql lib/freetype xorg/xorg qt/qt system/lirc

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

PWD := $(shell pwd)

CONFIGURE_SCRIPTS  = $(WORKSRC)/configure
CONFIGURE_SCRIPTS += $(WORKSRC)/mythtv
BUILD_SCRIPTS      = $(WORKSRC)/Makefile
INSTALL_SCRIPTS    = $(WORKSRC)/Makefile source

CONFIGURE_ARGS = \
	--compile-type=$(if $(filter yes,$(mm_DEBUG)),"debug","release") \
	--prefix="$(prefix)" \
	--disable-ccache \
	--disable-distcc \
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
	--enable-dvd \
	$(if $(filter yes,$(mm_DEBUG)),--enable-valgrind,--disable-valgrind) \
	--enable-frontend \
	--enable-backend \
	--enable-lirc \
	--enable-joystick-menu \
	--disable-firewire \
	--disable-dbox2 \
	--disable-v4l \
	--disable-ivtv \
	--disable-dvb \
	--dvb-path="$(DESTDIR)$(LINUX_SOURCEDIR)/include" \
	--disable-dvb-eit \
	--enable-x11 \
	--x11-path="$(DESTDIR)$(includedir)" \
	--enable-xrandr \
	--enable-xv \
	--enable-xvmc \
	--enable-xvmc-pro \
	--enable-opengl-vsync \
	--disable-directfb \
	--disable-directx

CONFIGURE_ENV = $(MYTHTV_CONFIGURE_ENV)
BUILD_ENV     = $(MYTHTV_BUILD_ENV)
INSTALL_ENV   = $(MYTHTV_INSTALL_ENV)

GAR_EXTRA_CONF += $(CATEGORY)/myth/package-api.mk kernel-$(mm_KERNEL_VERSION)/linux/package-api.mk
include ../../gar.mk

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
	@echo "$(GARVERSION) with fixes through SVN $(MYTHTV_STABLE19_FIXES_VERSION)" > $(DESTDIR)$(versiondir)/$(GARNAME)
	@$(MAKECOOKIE)
