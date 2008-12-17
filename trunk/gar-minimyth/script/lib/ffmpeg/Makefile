GARNAME = ffmpeg
GARVERSION = 16182.28158
CATEGORIES = lib
MASTER_SITES = svn://svn.mplayerhq.hu/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-vdpau_libavcodec_3219724.patch $(DISTNAME)-vdpau_libavutil_3219724.patch $(DISTNAME)-vdpau_configure_3219724.patch $(DISTNAME).patch.gar
LICENSE = GPL2/LGPL2_1

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c lib/zlib utils/bzip2 X11/vdpau
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
	--libdir=$(libdir) \
	--shlibdir=$(libdir) \
	--incdir=$(includedir)/ffmpeg \
	--mandir=$(mandir) \
	--disable-static \
	--enable-shared \
	--enable-gpl \
	--disable-nonfree \
	--enable-postproc \
	--enable-swscale \
	--disable-avfilter \
	--disable-avfilter-lavf \
	--disable-vhook \
	--disable-beosthreads \
	--disable-os2threads \
	--enable-pthreads \
	--disable-w32threads \
	--enable-x11grab \
	--enable-xvmc \
	--enable-vdpau \
	--disable-mlib \
	--disable-avisynth \
	--enable-bzlib \
	--disable-libamr-nb \
	--disable-libamr-wb \
	--disable-libdc1394 \
	--disable-libdirac \
	--disable-libfaac \
	--disable-libfaad \
	--disable-libfaadbin \
	--disable-libgsm \
	--disable-libmp3lame \
	--disable-libnut \
	--disable-libschroedinger \
	--disable-libspeex \
	--disable-libtheora \
	--disable-libvorbis \
	--disable-libx264 \
	--disable-libxvid \
	--enable-zlib \
	--cross-prefix=$(compiler_prefix) \
	--enable-cross-compile \
	--target-os="linux" \
	--nm="$(NM)" \
	--cc="$(CC)" \
	--host-cc="$(build_CC)" \
	--host-cflags="$(build_CFLAGS)" \
	--host-ldflags="$(build_LDFLAGS)" \
	--host-libs="" \
	--extra-cflags="$(CFLAGS)" \
	--extra-ldflags="$(LDFLAGS)" \
	--extra-libs="" \
	--extra-version="" \
	--build-suffix="" \
	--arch=$(GARCH_FAMILY) \
	--cpu=$(GARCH) \
	--disable-powerpc-perf \
	--disable-altivec \
	--enable-mmx \
	--enable-mmx2 \
	--enable-ssse3 \
	--disable-armv5te \
	--disable-armv6 \
	--disable-armvfp \
	--disable-iwmmxt \
	--disable-mmi \
	--disable-neon \
	--disable-vis \
	--enable-network \
	--disable-ipv6 \
	--disable-mpegaudio-hp \
	--enable-aandct \
	--enable-fft \
	--enable-golomb \
	--enable-mdct \
	--disable-gray \
	--enable-ffmpeg \
	--disable-ffplay \
	--disable-ffserver \
	$(if $(filter -Os,$(CFLAGS)),--enable-small) \
	--disable-hardcoded-tables \
	--disable-memalign-hack \
	--disable-beos-netserver \
	--enable-encoders \
	--enable-decoders \
	--enable-muxers \
	--enable-demuxers \
	--enable-parsers \
	--enable-bsfs \
	--disable-protocols \
	--enable-indevs \
	--enable-outdevs \
	--enable-filters \
	--disable-debug \
	--disable-gprof \
	--enable-optimizations \
	--disable-extra-warnings \
	--disable-stripping

CONFIGURE_ENV = \
	SDL_CONFIG='/bin/false'

include ../../gar.mk

svn//%/$(DISTNAME).tar.bz2:
	@$(call FETCH_SVN, svn://$*, $(GARVERSION), $(DISTNAME))
	@$(MAKECOOKIE)

# When using the SVN version, GARVERSION must have the form <ffmpeg-svn-version>.<mplayer-svn-version>.
# This is done to ensure that the correct version of libswscale is used.
svn//%/$(DISTNAME).tar.bz2:
	@$(call FETCH_SVN, svn://$*/ffmpeg/trunk            , $(word 1,$(subst ., ,$(GARVERSION))), $(DISTNAME))
	@$(call FETCH_SVN, svn://$*/mplayer/trunk/libswscale, $(word 2,$(subst ., ,$(GARVERSION))), libswscale )
	@cd $(PARTIALDIR) ; tar -jxf $(DISTNAME).tar.bz2 ; rm -r $(DISTNAME).tar.bz2
	@cd $(PARTIALDIR) ; tar -jxf libswscale.tar.bz2  ; rm -r libswscale.tar.bz2  ; rm -rf $(DISTNAME)/libswscale ; mv libswscale $(DISTNAME)/
	@cd $(PARTIALDIR) ; tar -jcf $(DISTNAME).tar.bz2 $(DISTNAME)
	@cd $(PARTIALDIR) ; rm -rf $(DISTNAME)
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)
