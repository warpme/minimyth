GARNAME = mythtv
GARVERSION = $(mm_MYTH_SVN_VERSION)
CATEGORIES = $(CATEGORY)
MASTER_SITES = svn://svn.mythtv.org/svn/trunk/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(GARNAME)-eject.patch $(GARNAME).patch.gar $(GARNAME)-init.patch $(GARNAME)-mythstream.patch $(GARNAME)-minimyth.patch $(GARNAME)-programid.patch $(GARNAME)-fadeaway.patch $(GARNAME)-preserve_timestamps.patch
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
	--arch=$(GARCH) \
	--tune=$(GARCH) \
	--cpu=$(GARCH) \
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
	--enable-xvmc-pro \
	--disable-xvmc-opengl \
	--xvmc-lib=XvMCW \
	--disable-mac-accel \
	--enable-opengl-vsync \
	--disable-directfb \
	--disable-directx \
	--without-bindings="perl"

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
