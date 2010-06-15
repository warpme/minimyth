GARNAME = vlc
GARVERSION = 1.1.0-rc3
CATEGORIES = mediaplayers
PATCHFILES  =
MASTER_SITES  = http://download.videolan.org/pub/videolan/$(GARNAME)/$(GARVERSION)/
MASTER_SITES += http://download.videolan.org/pub/videolan/testing/$(DISTNAME)/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lang/cxx \
	lib/a52dec \
	lib/alsa-lib \
	lib/faad2 \
	lib/ffmpeg \
	lib/fontconfig \
	lib/freetype \
	lib/libcdio \
	lib/libdvdnav \
	lib/libdvbpsi \
	lib/libdca \
	lib/libmad \
	lib/libmatroska \
	lib/libmpeg2 \
	lib/libpng \
	lib/libtheora \
	lib/libvorbis \
	lib/libxml2 \
	lib/taglib \
	lib/zlib \
	qt/qt4 \
	system/lirc \
	X11/libvdpau \
	xorg/xorg

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes=$(DESTDIR)$(includedir) \
	--x-libraries=$(DESTDIR)$(libdir) \
	--enable-option-checking \
	--disable-silent-rules \
	--without-contrib \
	--disable-macosx-defaults \
	--disable-peflags \
	--disable-static \
	--enable-shared \
	--with-gnu-ld \
	--enable-nls \
	--disable-rpath \
	--disable-dbus \
	--disable-dbus-control \
	--disable-telepathy \
	--disable-gprof \
	--disable-cprof \
	--enable-mmx \
	--enable-sse \
	--disable-neon \
	--disable-altivec \
	--with-tuning=$(GARCH) \
	--disable-optimize-memory \
	--disable-optimizations \
	--disable-debug \
	--disable-run-as-root \
	--disable-coverage \
	--enable-sout \
	--disable-lua \
	--disable-httpd \
	--disable-libproxy \
	--disable-vlm \
	--disable-growl \
	--disable-notify \
	--enable-taglib \
	--disable-live555 \
	--disable-dc1394 \
	--disable-dv \
	--disable-dvdread \
	--enable-dvdnav \
	--with-dvdnav-config-path=$(DESTDIR)$(bindir) \
	--disable-dshow \
	--disable-bda \
	--disable-opencv \
	--disable-smb \
	--disable-sftp \
	--enable-dvbpsi \
	--disable-v4l \
	--disable-libv4l \
	--disable-v4l2 \
	--disable-libv4l2 \
	--disable-pvr \
	--disable-gnomevfs \
	--disable-vcdx \
	--enable-vcd \
	--disable-libcddb \
	--disable-dvb \
	--disable-screen \
	--disable-ogg \
	--disable-mux_ogg \
	--disable-shout \
	--enable-mkv \
	--disable-mod \
	--disable-mpc \
	--disable-gme \
	--disable-wma-fixed \
	--disable-shine \
	--disable-omxil \
	--enable-mad \
	--disable-id3tag \
	--disable-merge-ffmpeg \
	--enable-avcodec \
	--enable-libva \
	--disable-dxva2 \
	--disable-switcher \
	--enable-avformat \
	--enable-swscale \
	--enable-postproc \
	--enable-faad \
	--disable-twolame \
	--disable-quicktime \
	--disable-real \
	--disable-realrtsp \
	--disable-libtar \
	--enable-a52 \
	--enable-dca \
	--disable-flac \
	--enable-libmpeg2 \
	--enable-vorbis \
	--disable-tremor \
	--disable-speex \
	--enable-theora \
	--disable-dirac \
	--disable-schroedinger \
	--enable-png \
	--disable-x264 \
	--disable-fluidsynth \
	--disable-zvbi \
	--disable-telx \
	--disable-libass \
	--disable-asademux \
	--disable-kate \
	--disable-tiger \
	--with-x \
	--enable-xcb \
	--enable-xvideo \
	--enable-glx \
	--enable-opengl \
	--disable-sdl \
	--disable-sdl-image \
	--enable-freetype \
	--disable-fribidi \
	--enable-fontconfig \
	--enable-libxml2 \
	--disable-svg \
	--disable-snapshot \
	--disable-hd1000v \
	--disable-directx \
	--disable-wingdi \
	--disable-fb \
	--disable-omapfb \
	--disable-svgalib \
	--disable-directfb \
	--disable-ggi \
	--disable-aa \
	--disable-caca \
	--disable-oss \
	--disable-pulse \
	--disable-portaudio \
	--enable-alsa \
	--disable-waveout \
	--disable-macosx-audio \
	--disable-hd1000a \
	--disable-jack \
	--disable-cyberlink \
	--disable-upnp \
	--disable-skins2 \
	--disable-hildon \
	--enable-qt4 \
	--disable-macosx \
	--disable-ncurses \
	--disable-xosd \
	--disable-fbosd \
	--disable-visual \
	--disable-goom \
	--disable-projectm \
	--disable-atmo \
	--disable-bonjour \
	--disable-udev \
	--disable-mtp \
	--enable-lirc \
	--disable-libgcrypt \
	--disable-gnutls \
	--disable-remoteosd \
	--disable-osso_screensaver \
	--disable-update-check \
	--disable-sqlite \
	--disable-loader \
	--enable-vlc \
	--disable-activex \
	--disable-mozilla
CONFIGURE_ENV = \
	ac_cv_path_MOC=$(DESTDIR)$(qt4bindir)/moc \
	ac_cv_path_RCC=$(DESTDIR)$(qt4bindir)/rcc \
	ac_cv_path_UIC=$(DESTDIR)$(qt4bindir)/uic

include ../../gar.mk

# Fails to compile with GCC's graphite.
CFLAGS   := $(filter-out -ftree-loop-distribution -floop-interchange -floop-strip-mine -floop-block -fgraphite-identity, $(CFLAGS))
CXXFLAGS := $(filter-out -ftree-loop-distribution -floop-interchange -floop-strip-mine -floop-block -fgraphite-identity, $(CXXFLAGS))

# Fails to compile with GCC's link time optimization (autoconf adds duplicate object files).
CFLAGS   := $(filter-out -flto -fuse-linker-plugin, $(CFLAGS))
CXXFLAGS := $(filter-out -flto -fuse-linker-plugin, $(CXXFLAGS))
LDFLAGS  := $(filter-out -flto -fuse-linker-plugin, $(LDFLAGS))

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libvlc.la
	@rm -f $(DESTDIR)$(libdir)/libvlccore.la
	@rm -f `find $(DESTDIR)$(libdir)/vlc -name *.la`
	@$(MAKECOOKIE)

clean-all:
	@$(MAKE) -C ../vlc clean
	@rm -rf $(DESTDIR)$(bindir)/vlc
	@rm -rf $(DESTDIR)$(bindir)/cvlc
	@rm -rf $(DESTDIR)$(bindir)/qvlc
	@rm -rf $(DESTDIR)$(bindir)/rvlc
	@rm -rf $(DESTDIR)$(bindir)/vlc-wrapper
	@rm -rf $(DESTDIR)$(includedir)/vlc
	@rm -rf $(DESTDIR)$(libdir)/vlc
	@rm -rf $(DESTDIR)$(libdir)/libvlc.*
	@rm -rf $(DESTDIR)$(libdir)/libvlccore.*
	@rm -rf $(DESTDIR)$(datadir)/vlc
	@rm -rf $(DESTDIR)$(docdir)/vlc
