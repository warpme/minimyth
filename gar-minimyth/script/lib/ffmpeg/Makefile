GARNAME = ffmpeg
GARVERSION = 19012.$(MPLAYER_TRUNK_VERSION)
CATEGORIES = lib
MASTER_SITES = svn://svn.ffmpeg.org/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(GARNAME)-mt-94985fa9745e2affd0cf3145fa35cb8ae87e7848.patch $(GARNAME).patch.gar
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
	--datadir=$(datadir)/ffmpeg \
	--libdir=$(libdir) \
	--shlibdir=$(libdir) \
	--incdir=$(includedir)/ffmpeg \
	--mandir=$(mandir) \
	--disable-static \
	--enable-shared \
	--enable-gpl \
	--disable-nonfree \
	--enable-ffmpeg \
	--disable-ffplay \
	--disable-ffserver \
	--enable-postproc \
	--disable-avfilter \
	--disable-avfilter-lavf \
	--disable-beosthreads \
	--disable-os2threads \
	--enable-pthreads \
	--disable-w32threads \
	--enable-x11grab \
	--enable-network \
	--disable-ipv6 \
	--disable-mpegaudio-hp \
	--disable-gray \
	--enable-fastdiv \
	$(if $(filter -Os,$(CFLAGS)),--enable-small) \
	--enable-aandct \
	--enable-fft \
	--enable-golomb \
	--enable-mdct \
	--enable-rdft \
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
	--disable-libopenjpeg \
	--disable-libschroedinger \
	--disable-libspeex \
	--disable-libtheora \
	--disable-libvorbis \
	--disable-libx264 \
	--disable-libxvid \
	--disable-mlib \
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
	--enable-amd3dnow \
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
	--disable-debug \
	--disable-gprof \
	--enable-optimizations \
	--disable-extra-warnings \
	--disable-stripping

CONFIGURE_ENV = \
	SDL_CONFIG='/bin/false'

GAR_EXTRA_CONF += mediaplayers/mplayer-svn/package-api.mk
include ../../gar.mk

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
		SIMPLE_BACKUP_SUFFIX=.gar-source-patches-update patch -p1 < ../../../files/$(PATCHFILE) || exit 1 ; \
		cd ../ || exit 1 ; \
		find $(DISTNAME)-new -name *.gar-source-patches-update -exec rm {} \; || exit 1 ; \
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
