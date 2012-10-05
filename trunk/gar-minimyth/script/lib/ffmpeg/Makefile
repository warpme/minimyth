GARNAME = ffmpeg
GARVERSION = 1.0
CATEGORIES = lib
MASTER_SITES = http://ffmpeg.org/releases/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-pkg_config.patch $(DISTNAME)-uint64_c.patch $(DISTNAME)-libswscale_symbol_export.patch
LICENSE = GPL2/LGPL2_1

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c lib/libbluray lib/SDL lib/zlib net/librtmp utils/bzip2 X11/libva X11/libvdpau
BUILDDEPS = devel/yasm

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

# The headers files are put in a sub-directory so that the libav*/*.h files
# do not conflict with the libav*/.h files in MythTV 0.20.
# --enable-devices is not supported (only --disable-devices).
CONFIGURE_ARGS = \
	--enable-logging \
	--prefix=$(prefix) \
	--bindir=$(bindir) \
	--datadir=$(datadir)/ffmpeg \
	--libdir=$(libdir) \
	--shlibdir=$(libdir) \
	--incdir=$(includedir) \
	--mandir=$(mandir) \
	--disable-static \
	--enable-shared \
	--enable-gpl \
	--disable-version3 \
	--disable-nonfree \
	--enable-doc \
	--enable-htmlpages \
	--enable-manpages \
	--enable-podpages \
	--enable-txtpages \
	--enable-ffmpeg \
	--disable-ffplay \
	--disable-ffprobe \
	--disable-ffserver \
	--enable-avdevice \
	--enable-avcodec \
	--enable-avformat \
	--enable-swresample \
	--enable-swscale \
	--enable-postproc \
	--enable-avfilter \
	--enable-pthreads \
	--disable-w32threads \
	--disable-os2threads \
	--enable-x11grab \
	--enable-network \
	--disable-gray \
	--enable-swscale-alpha \
	$(if $(filter -Os,$(CFLAGS)),--enable-small) \
	--enable-dct \
	--disable-dwt \
	--disable-lsp \
	--enable-fft \
	--enable-mdct \
	--enable-rdft \
	--enable-vaapi \
	--disable-vda \
	--enable-vdpau \
	--disable-dxva2 \
	--disable-vda \
	--enable-runtime-cpudetect \
	--disable-hardcoded-tables \
	--enable-safe-bitstream-reader \
	--disable-memalign-hack \
	--disable-encoders \
	--enable-decoders \
	--enable-hwaccels \
	--disable-muxers \
	--enable-demuxers \
	--enable-parsers \
	--enable-bsfs \
	--enable-protocols \
	--enable-indevs \
	--enable-outdevs \
	--enable-filters \
	--disable-avisynth \
	--enable-bzlib \
	--disable-frei0r \
	--disable-gnutls \
	--disable-libaacplus \
	--disable-libass \
	--enable-libbluray \
	--disable-libcaca \
	--disable-libcelt \
	--disable-libopencv \
	--disable-libcdio \
	--disable-libdc1394 \
	--disable-libfaac \
	--disable-libfdk-aac \
	--disable-libflite \
	--disable-libfreetype \
	--disable-libgsm \
	--disable-libiec61883 \
	--disable-libilbc \
	--disable-libmodplug \
	--disable-libmp3lame \
	--disable-libnut \
	--disable-libopenjpeg \
	--disable-libpulse \
	--enable-librtmp \
	--disable-libschroedinger \
	--disable-libspeex \
	--disable-libstagefright-h264 \
	--disable-libtheora \
	--disable-libutvideo \
	--disable-libv4l2 \
	--disable-libvo-aacenc \
	--disable-libvo-amrwbenc \
	--disable-libvorbis \
	--disable-libvpx \
	--disable-libx264 \
	--disable-libxavs \
	--disable-libxvid \
	--disable-openal \
	--disable-openssl \
	--enable-zlib \
	--cross-prefix=$(compiler_prefix) \
	--enable-cross-compile \
	--sysroot="$(DESTDIR)$(rootdir)" \
	--sysinclude="$(DESTDIR)$(includedir)" \
	--target-os="linux" \
	--nm="$(NM)" \
	--ar="$(AR)" \
	--as="$(CC)" \
	--yasmexe="yesm" \
	--cc="$(CC)" \
	--cxx="$(CXX)" \
	--ld="$(CC)" \
	--host-cc="$(build_CC)" \
	--host-cflags="$(build_CFLAGS)" \
	--host-ldflags="$(build_LDFLAGS)" \
	--host-libs="" \
	--extra-cflags="$(CFLAGS)" \
	--extra-cxxflags="$(CXXFLAGS)" \
	--extra-ldflags="$(LDFLAGS)" \
	--extra-libs="" \
	--extra-version="" \
	--build-suffix="" \
	--arch=$(GARCH_FAMILY) \
	--cpu=$(GARCH) \
	--enable-asm \
	--disable-altivec \
	--enable-amd3dnow \
	--enable-amd3dnowext \
	--enable-mmx \
	--enable-mmxext \
	--enable-sse \
	--enable-sse2 \
	--enable-sse3 \
	--enable-ssse3 \
	--disable-sse4 \
	--disable-sse42 \
	--disable-avx \
	--disable-fma4  \
	--disable-armv5te \
	--disable-armv6 \
	--disable-armv6t2 \
	--disable-armvfp \
	--disable-mmi \
	--disable-neon \
	--disable-vis \
	--enable-inline-asm \
	--enable-yasm \
	--disable-sram \
	--disable-symver \
	--disable-thumb \
	--postproc-version="current" \
	--disable-coverage \
	--disable-debug \
	--enable-optimizations \
	--disable-extra-warnings \
	--disable-stripping
BUILD_ARGS     = \
	V='1'
INSTALL_ARGS   = \
	V='1'

GAR_EXTRA_CONF += mediaplayers/mplayer-svn/package-api.mk
include ../../gar.mk

# ffmpeg 0.11.1 fails to compile with GCC 4.7.1's link time optimization enabled.
CFLAGS  := $(filter-out -flto, $(CFLAGS))
LDFLAGS := $(filter-out -flto, $(LDFLAGS))

post-install:
	@cp -f $(WORKSRC)/libavcodec/vaapi.h $(DESTDIR)`pkg-config --variable=includedir libavcodec`/libavcodec/vaapi.h
	@$(MAKECOOKIE)

clean-all:
	@$(MAKE) clean
	@rm -rf $(DESTDIR)$(includedir)/libavcodec
	@rm -rf $(DESTDIR)$(includedir)/libavdevice
	@rm -rf $(DESTDIR)$(includedir)/libavfilter
	@rm -rf $(DESTDIR)$(includedir)/libavformat
	@rm -rf $(DESTDIR)$(includedir)/libavutil
	@rm -rf $(DESTDIR)$(includedir)/libpostproc
	@rm -rf $(DESTDIR)$(includedir)/libswscale
	@rm -rf $(DESTDIR)$(libdir)/libavcodec.*
	@rm -rf $(DESTDIR)$(libdir)/libavdevice.*
	@rm -rf $(DESTDIR)$(libdir)/libavfilter.*
	@rm -rf $(DESTDIR)$(libdir)/libavformat.*
	@rm -rf $(DESTDIR)$(libdir)/libavutil.*
	@rm -rf $(DESTDIR)$(libdir)/libpostproc.*
	@rm -rf $(DESTDIR)$(libdir)/libswscale.*
	@rm -rf $(DESTDIR)$(datadir)/ffmpeg
	@rm -rf $(DESTDIR)$(bin)/ffmpeg
