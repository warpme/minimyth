GARNAME = mythtv
GARVERSION = $(MYTHTV_STABLE_VERSION)
CATEGORIES = myth
MASTER_SITES  = http://www.mythtv.org/mc/
MASTER_SITES += svn://svn.mythtv.org/svn/trunk/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-fixes-8395.patch $(DISTNAME).patch.gar $(DISTNAME)-xvmc_vld.patch $(DISTNAME)-init.patch $(DISTNAME)-mythstream.patch $(DISTNAME)-remove_import_menu_items.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lang/c++ lib/lame lib/alsa-lib lib/zlib db/mysql X11/freetype X11/X11 X11/libXvMCW qt/qt lirc/lirc

PWD := $(shell pwd)

CONFIGURE_SCRIPTS += $(WORKSRC)/configure
CONFIGURE_SCRIPTS += $(WORKSRC)/mythtv
BUILD_SCRIPTS     += $(WORKSRC)/Makefile
INSTALL_SCRIPTS   += $(WORKSRC)/Makefile source

CONFIGURE_ARGS = $(DIRPATHS) \
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
CONFIGURE_ENV += \
	DESTDIR="$(DESTDIR)" \
	QTDIR="$(DESTDIR)$(qtprefix)" \
	OPTFLAGS="$(CFLAGS)"
BUILD_ENV     += \
	DESTDIR="$(DESTDIR)" \
	QTDIR="$(DESTDIR)$(qtprefix)" \
	OPTFLAGS="$(CFLAGS)"
INSTALL_ARGS  += \
	INSTALL_ROOT="$(DESTDIR)"

GAR_EXTRA_CONF += kernel/linux/package-api.mk
include ../../gar.mk

svn//%/$(DISTNAME).tar.bz2:
	@cd $(PARTIALDIR); rm -rf $(GARNAME)
	@cd $(PARTIALDIR); svn co -r $(GARVERSION) http://$*
	@cd $(PARTIALDIR); rm -rf $(DISTNAME)
	@cd $(PARTIALDIR); mv $(GARNAME) $(DISTNAME)
	@cd $(PARTIALDIR); tar -jcf $(DISTNAME).tar.bz2 $(DISTNAME)
	@cd $(PARTIALDIR); rm -rf $(DISTNAME)
	@$(MAKECOOKIE)

disabled-checksum-$(DISTNAME).tar.bz2:
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
