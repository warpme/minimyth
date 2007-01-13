GARNAME = mythtv
GARVERSION = 0.18.1
CATEGORIES = myth
MASTER_SITES = http://www.mythtv.org/mc/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-fixes-$(MYTHTV_STABLE18_FIXES_VERSION).patch $(DISTNAME).patch.gar $(DISTNAME)-xvmc_vld.patch $(DISTNAME)-init.patch $(DISTNAME)-mythstream.patch $(DISTNAME)-gant.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lang/c++ lib/lame lib/alsa-lib lib/zlib db/mysql lib/freetype xorg/xorg qt/qt lirc/lirc

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
	$(if $(filter i386,$(GARCH_FAMILY)),--enable-mmx,--disable-mmx) \
	--disable-altivec \
	--disable-audio-oss \
	--enable-audio-alsa \
	--disable-audio-arts \
	--disable-audio-jack \
	--enable-lirc \
	--disable-joystick-menu \
	--disable-firewire \
	--disable-ivtv \
	--disable-dvb \
	--dvb-path="$(DESTDIR)$(KERNEL_SOURCEDIR)" \
	--disable-dvb-eit \
	--enable-x11 \
	--enable-xrandr \
	--enable-xv \
	--enable-xvmc \
	--enable-xvmc-vld \
	--disable-opengl-vsync \
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

GAR_EXTRA_CONF += kernel/linux/package-api.mk
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
	@rm -rf $(DESTDIR)$(datadir)/mythtv/FreeMono.ttf
	@ln -sf ./$(call DIRSTODOTS,$(datadir)/mythtv)/$(libdir)/X11/fonts/TTF/luximr.ttf $(DESTDIR)$(datadir)/mythtv/luximr.ttf
	@rm -rf $(DESTDIR)$(datadir)/mythtv/FreeSans.ttf
	@ln -sf ./$(call DIRSTODOTS,$(datadir)/mythtv)/$(libdir)/X11/fonts/TTF/luxisr.ttf $(DESTDIR)$(datadir)/mythtv/luxisr.ttf
	@$(MAKECOOKIE)
