GARNAME = ffmpeg
GARVERSION = 15845.27942
CATEGORIES = lib
MASTER_SITES = svn://svn.mplayerhq.hu/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-nvidia_vdpau_3076399.patch $(DISTNAME).patch.gar $(DISTNAME)-configure_accel.patch 
LICENSE = GPL2/LGPL2_1

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c lib/SDL lib/zlib utils/bzip2 X11/vdpau
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
	--disable-beosthreads \
	--disable-os2threads \
	--enable-pthreads \
	--disable-w32threads \
	--enable-x11grab \
	--disable-mlib \
	--disable-avisynth \
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
	--cross-prefix=$(compiler_prefix) \
	--enable-cross-compile \
	--target-os="linux" \
	--cc="$(CC)" \
	--extra-cflags="$(CFLAGS)" \
	--extra-ldflags="$(LDFLAGS)" \
	--extra-libs="" \
	--extra-version="" \
	--build-suffix="" \
	--arch=$(GARCH_FAMILY) \
	--cpu=$(GARCH) \
	--disable-powerpc-perf \
	--enable-mmx \
	--enable-mmx2 \
	--enable-ssse3 \
	--disable-armv5te \
	--disable-armv6 \
	--disable-armvfp \
	--disable-iwmmxt \
	--disable-altivec \
	--enable-network \
	--disable-ipv6 \
	--enable-zlib \
	--enable-bzlib \
	--disable-vhook \
	--disable-mpegaudio-hp \
	--enable-gray \
	--enable-ffmpeg \
	--disable-ffserver \
	--disable-ffplay \
	$(if $(filter -Os,$(CFLAGS)),--enable-small) \
	--disable-hardcoded-tables \
	--disable-memalign-hack \
	--enable-encoders \
	--enable-decoders \
	--enable-muxers \
	--enable-demuxers \
	--enable-parsers \
	--enable-bsfs \
	--disable-protocols \
	--enable-filters \
	--disable-debug \
	--disable-gprof \
	--enable-optimizations \
	--disable-extra-warnings \
	--disable-stripping

CONFIGURE_ENV = \
	xvmc=yes \
	vdpau=yes

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
