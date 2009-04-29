GARNAME = mythtv
GARVERSION = $(GARVERSION_SHORT)-$(MYTHTV_SVN_VERSION)
CATEGORIES = $(CATEGORY)
MASTER_SITES = svn://svn.mythtv.org/svn/$(MYTHTV_SVN_BRANCH)/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES  =
PATCHFILES += \
	$(DISTNAME_SHORT)-changeset-18944.patch \
	$(DISTNAME_SHORT)-ffmpeg_changeset-17091.patch \
	$(DISTNAME_SHORT)-dvdnav_shared.patch \
	$(DISTNAME_SHORT)-libdvdread_udf.patch \
	$(DISTNAME_SHORT)-fftw3f.patch \
	$(DISTNAME_SHORT)-glvdpau20462.patch \
	$(DISTNAME_SHORT)-ticket-4792.patch \
	$(DISTNAME_SHORT)-ticket-6105-20090110.patch \
	$(DISTNAME_SHORT)-networkcontrol.patch \
	$(DISTNAME_SHORT)-eject.patch \
	$(DISTNAME_SHORT)-udevinfo.patch \
	$(DISTNAME_SHORT).patch.gar \
	$(DISTNAME_SHORT)-init.patch \
	$(DISTNAME_SHORT)-minimyth.patch \
	$(DISTNAME_SHORT)-programid.patch \
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
	lib/fftw3f \
	lib/freetype \
	lib/lame \
	lib/zlib \
	qt/qt3 \
	system/lirc \
	X11/vdpau \
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
	--target-os="linux" \
	--cc="gcc" \
	--extra-cflags="$(CFLAGS)" \
	--extra-cxxflags="$(CFLAGS)" \
	--extra-ldflags="$(LDFLAGS)" \
	--enable-symbol-visibility \
	--arch=$(GARCH_FAMILY) \
	--tune=$(GARCH) \
	--cpu=$(GARCH) \
	--enable-mmx \
	--enable-audio-oss \
	--enable-audio-alsa \
	--disable-audio-arts \
	--disable-audio-jack \
	--enable-libfftw3 \
	--disable-valgrind \
	--enable-lirc \
	--enable-joystick-menu \
	--disable-firewire \
	--disable-iptv \
	--disable-dbox2 \
	--disable-hdhomerun \
	--enable-v4l \
	--enable-ivtv \
	--enable-dvb \
	--dvb-path="$(DESTDIR)$(includedir)" \
	--enable-x11 \
	--x11-path="$(DESTDIR)$(includedir)" \
	--enable-xrandr \
	--enable-xv \
	--enable-xvmc \
	--enable-xvmcw \
	--enable-xvmc-pro \
	--disable-xvmc-opengl \
	--enable-vdpau \
	--xvmc-lib=XvMCW \
	--enable-opengl-video \
	--disable-mac-accel \
	--enable-opengl-vsync \
	--disable-directfb \
	--disable-directx \
	--disable-mac-bundle \
	--runtime-prefix="$(prefix)" \
	--without-bindings="perl,python" \
	--enable-libfaad \
	$(if $(filter -Os,$(CFLAGS)),--enable-small)

CONFIGURE_ENV = $(MYTHTV_CONFIGURE_ENV)
BUILD_ENV     = $(MYTHTV_BUILD_ENV)
INSTALL_ENV   = $(MYTHTV_INSTALL_ENV)

GAR_EXTRA_CONF += $(CATEGORY)/myth/package-api.mk
include ../../gar.mk

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
