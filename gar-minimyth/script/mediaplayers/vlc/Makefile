GARNAME = vlc
GARVERSION = 0.9.0-test1
CATEGORIES = mediaplayers
MASTER_SITES = http://download.videolan.org/pub/videolan/testing/$(DISTNAME)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME).patch.gar
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c \
	lib/a52dec \
	lib/alsa-lib \
	lib/faad2 \
	lib/ffmpeg \
	lib/freetype \
	lib/libcdio \
	lib/libdvdnav \
	lib/libdvbpsi \
	lib/libdca \
	lib/libgcrypt \
	lib/libmad \
	lib/libmatroska \
	lib/libpng \
	lib/libxml2 \
	lib/mpeg2dec \
	lib/sysfsutils \
	lib/taglib \
	lib/zlib \
	system/lirc \
	xorg/xorg

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes=$(DESTDIR)$(includedir) \
	--x-libraries=$(DESTDIR)$(libdir) \
	--disable-python-bindings \
	--disable-java-bindings \
	--enable-nls \
	--disable-rpath \
	--disable-hal \
	--disable-dbus \
	--disable-dbus-control \
	--disable-telepathy \
	--disable-gprof \
	--disable-cprof \
	--enable-mmx \
	--enable-sse \
	--disable-altivec \
	--disable-optimize-memory \
	--disable-optimizations \
	--disable-debug \
	--disable-coverage \
	--enable-release \
	--disable-sout \
	--disable-switcher \
	--disable-shout \
	--disable-lua \
	--disable-httpd \
	--disable-vlm \
	--disable-growl \
	--disable-notify \
	--disable-audioscrobbler \
	--disable-musicbrains \
	--enable-taglib \
	--disable-live555 \
	--disable-dc1394 \
	--disable-dv \
	--disable-dvdread \
	--enable-dvdnav \
	--disable-dshow \
	--disable-bda \
	--disable-opencv \
	--disable-smb \
	--enable-dvbpsi \
	--disable-v4l \
	--disable-v4l2 \
	--disable-pvr \
	--disable-gnomevfs \
	--enable-libcdio \
	--disable-cddax \
	--disable-libcddb \
	--disable-vcdx \
	--enable-cdda \
	--enable-vcd \
	--disable-dvb \
	--disable-screen \
	--disable-ogg \
	--enable-mkv \
	--disable-mod \
	--disable-mpc \
	--disable-gme \
	--enable-mad \
	--disable-id3tag \
	--enable-avcodec \
	--enable-avformat \
	--disable-swscale \
	--disable-imgresample \
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
	--disable-vorbis \
	--disable-tremor \
	--disable-speex \
	--disable-tarkin \
	--disable-theora \
	--disable-dirac \
	--enable-png \
	--disable-x264 \
	--disable-fluidsynth \
	--disable-zvbi \
	--disable-telx \
	--disable-csri \
	--disable-asademux \
	--disable-cmml \
	--disable-kate \
	--enable-x11 \
	--enable-xvideo \
	--enable-glx \
	--enable-xvmc \
	--enable-xinerama \
	--enable-opengl \
	--disable-sdl \
	--disable-sdl-image \
	--enable-freetype \
	--disable-fribidi \
	--enable-libxml2 \
	--disable-svg \
	--disable-snapshot \
	--disable-qte \
	--disable-hd1000v \
	--disable-directx \
	--disable-fb \
	--disable-mga \
	--disable-svgalib \
	--disable-directfb \
	--disable-ggi \
	--disable-glide \
	--disable-aa \
	--disable-caca \
	--disable-wingdi \
	--disable-oss \
	--disable-esd \
	--disable-pulse \
	--disable-portaudio \
	--disable-arts \
	--enable-alsa \
	--disable-waveout \
	--disable-macosx-audio \
	--disable-hd1000a \
	--disable-jack \
	--disable-cyberlink \
	--disable-upnp \
	--disable-skins2 \
	--disable-pda \
	--disable-wxwidgets \
	--disable-wince \
	--disable-opie \
	--disable-macosx \
	--disable-qnx \
	--disable-ncurses \
	--disable-xosd \
	--disable-fbosd \
	--disable-visual \
	--disable-galaktos \
	--disable-goom \
	--disable-atmo \
	--disable-bonjour \
	--enable-lirc \
	--enable-libgcrypt \
	--disable-gnutls \
	--disable-remoteosd \
	--disable-update-check \
	--disable-loader \
	--enable-vlc \
	--disable-activex \
	--disable-mozilla \
	--disable-testsuite \
	--without-contrib \
	--with-gnu-ld \
	--with-x \
	--with-tuning=$(mm_ARCH) \
	--with-dvdnav-config-path=$(DESTDIR)$(bindir) \
	--without-a52-fixed \
	--with-sdl-config-path=$(DESTDIR)$(bindir) \
	--with-xml2-config-path=$(DESTDIR)$(bindir) \
	--with-libgcrypt-prefix=$(DESTDIR)$(prefix)

CONFIGURE_ENV =

# Build VLC with the Qt4 GUI.
ifdef VLC_GUI_QT4
DEPENDS += \
	qt/qt4
CONFIGURE_ARGS += \
	--enable-qt4
CONFIGURE_ENV += \
	ac_cv_path_MOC=$(DESTDIR)$(qt4bindir)/moc \
	ac_cv_path_RCC=$(DESTDIR)$(qt4bindir)/rcc \
	ac_cv_path_UIC=$(DESTDIR)$(qt4bindir)/uic
else
CONFIGURE_ARGS += \
	--disable-qt4
endif

include ../../gar.mk

pre-configure:
	@$(call FIX_LIBTOOL_LIBPATH,$(WORKSRC),configure)
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
	@rm -rf $(DESTDIR)$(bindir)/vlc-config
	@rm -rf $(DESTDIR)$(includedir)/vlc
	@rm -rf $(DESTDIR)$(libdir)/vlc
	@rm -rf $(DESTDIR)$(libdir)/libvlc.*
	@rm -rf $(DESTDIR)$(datadir)/vlc
	@rm -rf $(DESTDIR)$(docdir)/vlc
