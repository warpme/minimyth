GARNAME = mythtv
GARVERSION = $(MYTHTV_VERSION)
CATEGORIES = myth
MASTER_SITES  = http://www.mythtv.org/mc/
MASTER_SITES += cvs://mythtv:mythtv@cvs.mythtv.org:/var/lib/mythcvs/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME).patch.gar $(DISTNAME)-cpu.patch $(DISTNAME)-init.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lang/c++ lib/lame lib/alsa-lib db/mysql X11/freetype X11/X11 X11/libXvMCW qt/qt lirc/lirc

CONFIGURE_SCRIPTS += $(WORKSRC)/configure
CONFIGURE_SCRIPTS += $(WORKSRC)/mythtv
BUILD_SCRIPTS     += $(WORKSRC)/Makefile
INSTALL_SCRIPTS   += $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) \
	--extra-cflags="$(CFLAGS)" \
	--extra-cxxflags="$(CFLAGS)" \
	--cpu=$(GARCH) \
	--tune=$(GARCH) \
	--arch=$(GARCH) \
	--enable-proc-opt \
	--enable-mmx \
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

GAR_EXTRA_CONF += kernel/linux/package-api.mk myth/mythtv/package-api.mk
include ../../gar.mk

cvs//%/$(DISTNAME).tar.bz2:
	@cd $(PARTIALDIR); rm -rf $(GARNAME)
	@cd $(PARTIALDIR); cvs -z3 -d:pserver:$* co -D $(GARVERSION) $(GARNAME)
	@cd $(PARTIALDIR); rm -rf $(DISTNAME)
	@cd $(PARTIALDIR); mv $(GARNAME) $(DISTNAME)
	@cd $(PARTIALDIR); tar -jc $(DISTNAME) -f $(DISTNAME).tar.bz2
	@cd $(PARTIALDIR); rm -rf $(DISTNAME)
	@$(MAKECOOKIE)

disabled-checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

configure-%/mythtv:
	@cd $* ; $(CONFIGURE_ENV) qmake $(GARNAME).pro
	@$(MAKECOOKIE)

clean-all:
	@$(foreach dir,$(wildcard ../myth*),$(MAKE) -C $(dir) clean ; )
	@rm -rf $(DESTDIR)$(bindir)/myth*
	@rm -rf $(DESTDIR)$(datadir)/myth*
	@rm -rf $(DESTDIR)$(includedir)/myth*
	@rm -rf $(DESTDIR)$(libdir)/libmyth*
	@rm -rf $(DESTDIR)$(libdir)/myth*
