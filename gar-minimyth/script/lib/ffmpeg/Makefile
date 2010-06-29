GARNAME = ffmpeg
GARVERSION = 23876.$(MPLAYER_TRUNK_VERSION)
CATEGORIES = lib
MASTER_SITES = svn://svn.ffmpeg.org/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(GARNAME)-uint64_c.patch $(GARNAME)-libswscale_symbol_export.patch $(GARNAME)-mt_20100624.patch
LICENSE = GPL2/LGPL2_1

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c lib/SDL lib/zlib net/librtmp utils/bzip2 X11/libva X11/libvdpau
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
	--incdir=$(includedir)/ffmpeg \
	--mandir=$(mandir) \
	--disable-static \
	--enable-shared \
	--enable-gpl \
	--disable-version3 \
	--disable-nonfree \
	--enable-doc \
	--enable-ffmpeg \
	--disable-ffplay \
	--disable-ffprobe \
	--disable-ffserver \
	--enable-avdevice \
	--enable-avcodec \
	--enable-avformat \
	--enable-swscale \
	--enable-postproc \
	--enable-avfilter \
	--disable-avfilter-lavf \
	--enable-pthreads \
	--disable-w32threads \
	--enable-x11grab \
	--enable-network \
	--disable-mpegaudio-hp \
	--disable-gray \
	--enable-swscale-alpha \
	--enable-fastdiv \
	$(if $(filter -Os,$(CFLAGS)),--enable-small) \
	--enable-aandct \
	--enable-dct \
	--enable-fft \
	--enable-golomb \
	--enable-lpc \
	--enable-mdct \
	--enable-rdft \
	--enable-vaapi \
	--enable-vdpau \
	--disable-dxva2 \
	--enable-runtime-cpudetect \
	--disable-hardcoded-tables \
	--disable-memalign-hack \
	--disable-encoders \
	--enable-decoders \
	--enable-hwaccels \
	--enable-muxers \
	--enable-demuxers \
	--enable-parsers \
	--enable-bsfs \
	--enable-protocols \
	--enable-indevs \
	--enable-outdevs \
	--enable-filters \
	--disable-avisynth \
	--enable-bzlib \
	--disable-libopencore-amrnb \
	--disable-libopencore-amrwb \
	--disable-libdc1394 \
	--disable-libdirac \
	--disable-libfaac \
	--disable-libgsm \
	--disable-libmp3lame \
	--disable-libnut \
	--disable-libopenjpeg \
	--enable-librtmp \
	--disable-libschroedinger \
	--disable-libspeex \
	--disable-libtheora \
	--disable-libvorbis \
	--disable-libvpx \
	--disable-libx264 \
	--disable-libxvid \
	--disable-mlib \
	--enable-zlib \
	--cross-prefix=$(compiler_prefix) \
	--enable-cross-compile \
	--sysroot="$(DESTDIR)$(rootdir)" \
	--sysinclude="$(DESTDIR)$(includedir)" \
	--target-os="linux" \
	--nm="$(NM)" \
	--ar="$(AR)" \
	--as="$(AS)" \
	--cc="$(CC)" \
	--ld="$(CC)" \
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
	--enable-asm \
	--disable-altivec \
	--enable-amd3dnow \
	--enable-amd3dnowext \
	--enable-mmx \
	--enable-mmx2 \
	--enable-sse \
	--enable-ssse3 \
	--disable-armv5te \
	--disable-armv6 \
	--disable-armv6t2 \
	--disable-armvfp \
	--disable-iwmmxt \
	--disable-mmi \
	--disable-neon \
	--disable-vis \
	--enable-yasm \
	--disable-sram \
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

# Fails to compile with GCC's link time optimization.
CFLAGS  := $(filter-out -flto -fuse-linker-plugin, $(CFLAGS))
LDFLAGS := $(filter-out -flto -fuse-linker-plugin, $(LDFLAGS))

svn//%/$(DISTNAME).tar.bz2:
	@$(call FETCH_SVN, svn://$*, $(GARVERSION), $(DISTNAME))
	@$(MAKECOOKIE)

# When using the SVN version, GARVERSION must have the form <ffmpeg-trunk-version>.<mplayer-trunk-version>.
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

post-install:
	@cp -f $(WORKSRC)/libavcodec/vaapi.h $(DESTDIR)`pkg-config --variable=includedir libavcodec`/libavcodec/vaapi.h
	@$(MAKECOOKIE)

clean-all:
	@$(MAKE) clean
	@rm -rf $(DESTDIR)$(includedir)/ffmpeg
	@rm -rf $(DESTDIR)$(libdir)/libavcodec.*
	@rm -rf $(DESTDIR)$(libdir)/libavdevice.*
	@rm -rf $(DESTDIR)$(libdir)/libavformat.*
	@rm -rf $(DESTDIR)$(libdir)/libavutil.*
	@rm -rf $(DESTDIR)$(libdir)/libpostproc.*
	@rm -rf $(DESTDIR)$(libdir)/libswscale.*
	@rm -rf $(DESTDIR)$(bin)/ffmpeg

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
		cat checksums | grep -v $(DOWNLOADDIR)/$(PATCHFILE) > checksums~ ; \
		md5sum $(DOWNLOADDIR)/$(PATCHFILE) >> checksums~ || exit 1 ; \
		rm -f checksums || exit 1 ; \
		mv -f checksums~ checksums || exit 1 ; )
	@$(MAKE) clean

FFMPEG_MT_VERSION_NORMAL=23671
FFMPEG_MT_VERSION_THREAD=7e928f69148f6c90d35715f4380accb6fc4e88c4
FFMPEG_MT_VERSION_DATE=20100624

source-update-mt:
	@cd $(PARTIALDIR) ; rm -rf ffmpeg-mt-normal.tar.bz2
	@$(call FETCH_SVN, svn://svn.ffmpeg.org/ffmpeg/trunk, $(FFMPEG_MT_VERSION_NORMAL), ffmpeg-mt-normal)
	@cd $(PARTIALDIR) ; rm -rf ffmpeg-mt-thread.tar.bz2
	@$(call FETCH_GIT, gitorious.org/~astrange/ffmpeg/ffmpeg-mt.git, $(FFMPEG_MT_VERSION_THREAD), ffmpeg-mt-thread)
	@cd $(PARTIALDIR) ; rm -rf ffmpeg-mt-normal
	@cd $(PARTIALDIR) ; tar -jxf ffmpeg-mt-normal.tar.bz2 && rm -rf ffmpeg-mt-normal/libswscale
	@cd $(PARTIALDIR) ; rm -rf ffmpeg-mt-normal.tar.bz2
	@cd $(PARTIALDIR) ; rm -rf ffmpeg-mt-thread
	@cd $(PARTIALDIR) ; tar -jxf ffmpeg-mt-thread.tar.bz2
	@cd $(PARTIALDIR) ; rm -rf ffmpeg-mt-thread.tar.bz2
	@cd $(PARTIALDIR) ; rm -rf ffmpeg-mt-thread/mt-work
	@cd $(PARTIALDIR) ; rm -f ffmpeg-mt_$(FFMPEG_MT_VERSION_DATE).patch
	@cd $(PARTIALDIR) ; diff -Naur ffmpeg-mt-normal ffmpeg-mt-thread > ffmpeg-mt_$(FFMPEG_MT_VERSION_DATE).patch || test $$? = 1
	@cd $(PARTIALDIR) ; rm -rf ffmpeg-mt-normal
	@cd $(PARTIALDIR) ; rm -rf ffmpeg-mt-thread
	@rm -f files/ffmpeg-mt_$(FFMPEG_MT_VERSION_DATE).patch 
	@mv $(PARTIALDIR)/ffmpeg-mt_$(FFMPEG_MT_VERSION_DATE).patch files/ffmpeg-mt_$(FFMPEG_MT_VERSION_DATE).patch
	@#cat checksums | grep -v $(DOWNLOADDIR)/ffmpeg-mt-*.patch > checksums~
	@#md5sum $(DOWNLOADDIR)/ffmpeg-mt-$(FFMPEG_MT_VERSION_DATE).patch >> checksums~ || exit 1
	@#rm -f checksums || exit 1
	@#mv -f checksums~ checksums || exit 1
