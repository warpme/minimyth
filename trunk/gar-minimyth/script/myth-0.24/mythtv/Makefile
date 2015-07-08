GARNAME = mythtv
GARVERSION = $(MYTHTV_GARVERSION)
CATEGORIES = $(CATEGORY)
MASTER_SITES = git://github.com/MythTV/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES  =
PATCHFILES += \
	$(GARNAME)-$(word 1,$(subst -, ,$(GARVERSION)))-v4l2.patch \
	$(GARNAME)-$(word 1,$(subst -, ,$(GARVERSION)))-codec_id_svq3_fix.patch \
	$(GARNAME)-$(word 1,$(subst -, ,$(GARVERSION)))-python_build.patch \
	$(GARNAME)-$(word 1,$(subst -, ,$(GARVERSION)))-max_num_xvmc_surfaces_14.patch \
	$(GARNAME)-$(word 1,$(subst -, ,$(GARVERSION)))-sysroot.patch \
	$(GARNAME)-$(word 1,$(subst -, ,$(GARVERSION)))-hulu.patch \
	$(GARNAME)-$(word 1,$(subst -, ,$(GARVERSION)))-networkcontrol.patch \
	$(GARNAME)-$(word 1,$(subst -, ,$(GARVERSION)))-eject.patch \
	$(GARNAME)-$(word 1,$(subst -, ,$(GARVERSION)))-drm_vsync_control.patch \
	$(GARNAME)-$(word 1,$(subst -, ,$(GARVERSION))).patch.gar \
	$(GARNAME)-$(word 1,$(subst -, ,$(GARVERSION)))-init.patch \
	$(GARNAME)-$(word 1,$(subst -, ,$(GARVERSION)))-minimyth.patch \
	$(GARNAME)-$(word 1,$(subst -, ,$(GARVERSION)))-programid.patch \
	$(GARNAME)-$(word 1,$(subst -, ,$(GARVERSION)))-cdio.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = \
	lang/cxx \
	db/mariadb \
	lib/alsa-lib \
	lib/fftw3 \
	lib/fftw3f \
	lib/freetype \
	lib/lame \
	lib/libavc1394 \
	lib/libiec61883 \
	lib/zlib \
	python/python \
	python/python-MySQL-python \
	python/python-lxml \
	qt/qt4 \
	system/lirc \
	system/udev \
	X11/libvdpau \
	xorg/xorg
BUILDDEPS = \
	devel/yasm \
	python/python-distutilscross \
	python/python-MySQL-python \
	python/python-lxml

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

PWD := $(shell pwd)

CONFIGURE_SCRIPTS = $(WORKSRC)/mythtv/configure
BUILD_SCRIPTS     = $(WORKSRC)/mythtv/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/mythtv/Makefile source

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
	--cross-prefix="$(compiler_prefix)" \
	--enable-cross-compile \
	--sysroot="$(DESTDIR)$(rootdir)" \
	--sysinclude="$(DESTDIR)$(includedir)" \
	--target-os="linux" \
	--nm="$(NM)" \
	--as="$(CC)" \
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
	--disable-v4l \
	--enable-v4l2 \
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
	--disable-quartz-video \
	--enable-opengl-vsync \
	--disable-mac-bundle \
	--without-bindings="perl" \
	--with-bindings="python"

CONFIGURE_ENV  = $(MYTHTV_CONFIGURE_ENV) \
	libfftw3='yes'
BUILD_ENV      = $(MYTHTV_BUILD_ENV)
INSTALL_ENV    = $(MYTHTV_INSTALL_ENV)

CONFIGURE_ENV += $(PERL_CONFIGURE_ENV)
#BUILD_ENV     += $(PERL_BUILD_ENV)
INSTALL_ENV   += $(PERL_INSTALL_ENV)

BUILD_ENV     += PYTHONXCPREFIX=$(DESTDIR)$(prefix)
INSTALL_ENV   += PYTHONPATH=$(DESTDIR)$(PYTHON_libdir)/site-packages

GAR_EXTRA_CONF += perl/perl/package-api.mk python/python/package-api.mk
include ../../gar.mk

# mythtv 0.24 fails to compile with gcc 5.1.0's link time optimization enabled.
CFLAGS   := $(filter-out -flto, $(CFLAGS))
CXXFLAGS := $(filter-out -flto, $(CXXFLAGS))
LDFLAGS  := $(filter-out -flto, $(LDFLAGS))

git//%/$(DISTNAME).tar.bz2:
	$(call FETCH_GIT, $*/mythtv.git,     $(word 3,$(subst -, ,$(GARVERSION))), $(DISTNAME))
	$(call FETCH_GIT, $*/myththemes.git, $(word 4,$(subst -, ,$(GARVERSION))), myththemes)
	@cd $(PARTIALDIR) ; tar -jxf $(DISTNAME).tar.bz2
	@cd $(PARTIALDIR) ; tar -jxf myththemes.tar.bz2
	@cd $(PARTIALDIR) ; rm -rf $(DISTNAME)/myththemes
	@cd $(PARTIALDIR) ; mv myththemes $(DISTNAME)/myththemes
	@cd $(PARTIALDIR) ; rm -rf   $(DISTNAME).tar.bz2
	@cd $(PARTIALDIR) ; tar -jcf $(DISTNAME).tar.bz2 $(DISTNAME)
	@cd $(PARTIALDIR) ; rm -rf                       $(DISTNAME)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

install-source:
	@rm -rf $(DESTDIR)$(MYTHTV_SOURCEDIR)
	@mkdir -p $(DESTDIR)$(MYTHTV_SOURCEDIR)
	@rm -rf $(DESTDIR)$(MYTHTV_SOURCEDIR)
	@ln -sf $(PWD)/$(WORKSRC)/mythtv $(DESTDIR)$(MYTHTV_SOURCEDIR)
	@$(MAKECOOKIE)

post-install: post-install-mythtv-version
	@rm -f $(DESTDIR)$(bindir)/mythtv
	@mv $(DESTDIR)$(bindir)/mythavtest $(DESTDIR)$(bindir)/mythtv
	@$(MAKECOOKIE)

clean-all:
	@rm -rf $(DESTDIR)$(bindir)/mtd
	@rm -rf $(DESTDIR)$(bindir)/myth*
	@rm -rf $(DESTDIR)$(datadir)/myth*
	@rm -rf $(DESTDIR)$(includedir)/myth*
	@rm -rf $(DESTDIR)$(libdir)/libmyth*
	@rm -rf $(DESTDIR)$(libdir)/myth*
	@rm -rf $(DESTDIR)$(libdir)/python*/site-packages/MythTV
	@rm -rf $(DESTDIR)$(libdir)/python*/site-packages/MythTV-*
	@$(foreach dir,$(filter-out %/Makefile,$(wildcard ../../myth/* ../../myth-*/*)),$(MAKE) -C $(dir) clean ; )

source-update:
	@$(MAKE) source-update-source
	@$(MAKE) source-update-patches

source-update-source:
	@$(MAKE) clean
	@$(MAKE) fetch
	@$(MAKE) $(GARCHIVEDIR)/$(DISTNAME).tar.bz2
	@$(MAKE) clean

source-update-patches:
	@$(MAKE) clean
	@$(MAKE) extract
	@$(foreach PATCHFILE, $(PATCHFILES), \
		cd $(WORKDIR) || exit 1 ; \
		mv $(DISTNAME) $(DISTNAME)-old || exit 1 ; \
		cp -r $(DISTNAME)-old $(DISTNAME)-new || exit 1 ; \
		cd $(DISTNAME)-new || exit 1 ; \
		SIMPLE_BACKUP_SUFFIX=.gar-source-update-patches patch -p1 < ../../../files/$(PATCHFILE) || exit 1 ; \
		cd ../ || exit 1 ; \
		find $(DISTNAME)-new -name *.gar-source-update-patches -exec rm {} \; || exit 1 ; \
		( diff -Naur $(DISTNAME)-old $(DISTNAME)-new > ../../files/$(PATCHFILE) ; test $$? -lt 2 ) || exit 1 ; \
		rm -fr $(DISTNAME)-old || exit 1 ; \
		mv $(DISTNAME)-new $(DISTNAME) || exit 1 ; \
		cd ../../ || exit 1 ; \
		rm -f checksums~ || exit 1 ; \
		cat checksums | grep -v $(DOWNLOADDIR)/$(PATCHFILE) > checksums~ || true ; \
		md5sum $(DOWNLOADDIR)/$(PATCHFILE) >> checksums~ || exit 1 ; \
		rm -f checksums || exit 1 ; \
		mv -f checksums~ checksums || exit 1 ; )
	@$(MAKE) clean
