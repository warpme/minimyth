GARNAME = mythtv
GARVERSION = $(GARVERSION_SHORT)-$(MYTHTV_SVN_VERSION)
CATEGORIES = $(CATEGORY)
MASTER_SITES = svn://svn.mythtv.org/svn/$(MYTHTV_SVN_BRANCH)/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES  =
PATCHFILES += \
	$(DISTNAME_SHORT)-python_cross.patch \
	$(DISTNAME_SHORT)-max_num_xvmc_surfaces_14.patch \
	$(DISTNAME_SHORT)-sysroot.patch \
	$(DISTNAME_SHORT)-dvdnav_shared.patch \
	$(DISTNAME_SHORT)-fftw3f.patch \
	$(DISTNAME_SHORT)-hulu.patch \
	$(DISTNAME_SHORT)-networkcontrol.patch \
	$(DISTNAME_SHORT)-eject.patch \
	$(DISTNAME_SHORT)-udevinfo.patch \
	$(DISTNAME_SHORT)-drm_vsync_control.patch \
	$(DISTNAME_SHORT).patch.gar \
	$(DISTNAME_SHORT)-init.patch \
	$(DISTNAME_SHORT)-minimyth.patch \
	$(DISTNAME_SHORT)-programid.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = \
	lang/cxx \
	db/mysql \
	lib/alsa-lib \
	lib/faad2 \
	lib/fftw3f \
	lib/freetype \
	lib/lame \
	lib/libavc1394 \
	lib/libiec61883 \
	lib/zlib \
	python/python \
	python/python-MySQL-python \
	python/python-PyXML \
	qt/qt4 \
	system/lirc \
	X11/libvdpau \
	xorg/xorg
BUILDDEPS = \
	devel/yasm \
	python/python

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

PWD := $(shell pwd)

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile source

CONFIGURE_ARGS = \
	--compile-type=$(if $(filter yes,$(mm_DEBUG)),"debug","release") \
	--prefix="$(prefix)" \
	--runprefix="$(prefix)" \
	--libdir-name="$(patsubst $(prefix)/%,%,$(libdir))" \
	--disable-ccache \
	--disable-distcc \
	--bindir="$(bindir)" \
	--datadir="$(datadir)" \
	--libdir="$(libdir)" \
	--shlibdir="$(libdir)" \
	--incdir="$(incdir)" \
	--mandir="$(mandir)" \
	$(if $(filter -Os,$(CFLAGS)),--enable-small) \
	--enable-libfaad \
	--cross-prefix="$(compiler_prefix)" \
	--enable-cross-compile \
	--sysroot="$(DESTDIR)$(rootdir)" \
	--sysinclude="$(DESTDIR)$(includedir)" \
	--target-os="linux" \
	--nm="$(NM)" \
	--as="$(AS)" \
	--cc="$(CC)" \
	--cxx="$(CXX)" \
	--qmake="$(DESTDIR)$(qt4bindir)/qmake" \
	--host-cc="$(build_CC)" \
	--host-cflags="$(build_CFLAGS)" \
	--host-ldflags="$(build_LDFLAGS)" \
	--host-libs="" \
	--extra-cflags="$(CFLAGS)" \
	--extra-cxxflags="$(CXXFLAGS)" \
	--extra-ldflags="$(LDFLAGS)" \
	--enable-symbol-visibility \
	--arch=$(GARCH_FAMILY) \
	--tune=$(GARCH) \
	--cpu=$(GARCH) \
	--disable-proc-opt \
	--disable-altivec \
	--enable-amd3dnow \
	--enable-amd3dnowext \
	--enable-mmx \
	--enable-mmx2 \
	--enable-sse \
	--enable-ssse3 \
	--enable-yasm \
	--enable-audio-oss \
	--enable-audio-alsa \
	--disable-audio-jack \
	--disable-audio-pulseoutput \
	--disable-valgrind \
	--enable-lirc \
	--enable-joystick-menu \
	--enable-firewire \
	--disable-iptv \
	--disable-hdhomerun \
	--enable-v4l \
	--enable-ivtv \
	--enable-hdpvr \
	--enable-dvb \
	--dvb-path="$(DESTDIR)$(includedir)" \
	--enable-x11 \
	--x11-path="$(DESTDIR)$(includedir)" \
	--enable-xrandr \
	--enable-xv \
	--enable-xvmc \
	--enable-xvmcw \
	--enable-xvmc-vld \
	--enable-vdpau \
	--xvmc-lib=XvMCW \
	--enable-opengl-video \
	--disable-mac-accel \
	--enable-opengl-vsync \
	--disable-mac-bundle \
	--without-bindings="perl" \
	--with-bindings="python"

CONFIGURE_ENV = $(MYTHTV_CONFIGURE_ENV)
BUILD_ENV     = $(MYTHTV_BUILD_ENV)
INSTALL_ENV   = $(MYTHTV_INSTALL_ENV)

BUILD_ENV     += PYTHONXCPREFIX=$(DESTDIR)$(prefix)
INSTALL_ENV   += PYTHONPATH=$(DESTDIR)$(PYTHON_libdir)/site-packages

GAR_EXTRA_CONF += $(CATEGORY)/myth/package-api.mk python/python/package-api.mk
include ../../gar.mk

# Fails to compile with GCC's link time optimization.
CFLAGS   := $(filter-out -flto -fuse-linker-plugin, $(CFLAGS))
CXXFLAGS := $(filter-out -flto -fuse-linker-plugin, $(CXXFLAGS))
LDFLAGS  := $(filter-out -flto -fuse-linker-plugin, $(LDFLAGS))

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
	@rm -f $(DESTDIR)$(bindir)/mythtv
	@mv $(DESTDIR)$(bindir)/mythavtest $(DESTDIR)$(bindir)/mythtv
	@$(MAKECOOKIE)
