GARNAME = MPlayer
GARVERSION = 1.0rc1
CATEGORIES = mediaplayers
MASTER_SITES  = http://www1.mplayerhq.hu/MPlayer/releases/
MASTER_SITES += http://www2.mplayerhq.hu/MPlayer/releases/
MASTER_SITES += http://www4.mplayerhq.hu/MPlayer/releases/
MASTER_SITES += svn://svn.mplayerhq.hu/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-asmrules_fix_20061231.patch $(DISTNAME)-openchrome.patch $(DISTNAME)-cross-$(GARCH_FAMILY).patch
LICENSE = mplayer
mplayer_LICENSE_TEXT = $(WORKSRC)/Copyright

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c kernel/kernel lib/alsa-lib lib/cdparanoia lib/faad2 lib/fontconfig lib/freetype lib/libdvdread lib/libdts lib/libjpeg lib/libmad lib/libogg lib/libpng lib/libtheora lib/libvorbis lib/SDL lib/zlib lirc/lirc xorg/xorg

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile config

# Directories
CONFIGURE_ARGS_DIR = \
	--prefix="$(prefix)" \
	--bindir="$(bindir)" \
	--datadir="$(datadir)/mplayer" \
	--mandir="$(mandir)" \
	--confdir="$(sysconfdir)/mplayer" \
	--libdir="$(libdir)"
# Optional features
CONFIGURE_ARGS_OPTIONAL = \
	--disable-mencoder \
	--disable-gui \
	--enable-largefiles \
	--disable-linux-devfs \
	--disable-termcap \
	--disable-termios \
	--enable-iconv \
	--enable-langinfo \
	--enable-lirc \
	--disable-lircc \
	--disable-joystick \
	--enable-vm \
	--enable-xf86keysym \
	--disable-tv \
	--disable-tv-v4l1 \
	--disable-tv-v4l2 \
	--disable-tv-bsdbt848 \
	--enable-rtc \
	--enable-network \
	--disable-winsock2 \
	--disable-smb \
	--disable-live \
	--disable-dvdnav \
	--enable-dvdread \
	--disable-mpdvdkit \
	--enable-cdparanoia \
	--enable-freetype \
	--enable-unrarlib \
	--enable-menu \
	--enable-sortsub \
	--disable-fribidi \
	--disable-enca \
	--disable-macosx \
	--disable-macosx-finder-support \
	--disable-macosx-bundle \
	--disable-inet6 \
	--enable-gethostbyname2 \
	--enable-ftp \
	--disable-vstream \
	--enable-pthreads \
	--disable-rpath
# Codecs
CONFIGURE_ARGS_CODEC = \
	--disable-gif \
	--enable-png \
	--enable-jpeg \
	--disable-libcdio \
	--disable-liblzo \
	$(if $(filter i386,$(GARCH_FAMILY)),--enable-win32,--disable-win32) \
	--disable-qtx \
	--enable-xanim \
	--enable-real \
	--disable-tremor-internal \
	--disable-tremor-external \
	--enable-libvorbis \
	--enable-theora \
	--disable-faad-internal \
	--enable-mad
# Video output: enable xv (requires x11 and vm) and xvmc
CONFIGURE_ARGS_VIDEO = \
	--disable-vidix-internal \
	--disable-vidix-external \
	--enable-gl \
	--disable-dga \
	--disable-vesa \
	--disable-svga \
	--enable-sdl \
	--disable-aa \
	--disable-caca \
	--disable-ggi \
	--disable-ggiwmh \
	--disable-directx \
	--disable-dxr2 \
	--disable-dxr3 \
	--disable-dvb \
	--disable-dvbhead \
	--disable-mga \
	--disable-xmga \
	--enable-xv \
	--enable-xvmc \
	--enable-vm \
	--enable-xinerama \
	--enable-x11 \
	--disable-fbdev \
	--disable-mlib \
	--disable-3dfx \
	--disable-tdfxfb \
	--disable-s3fb \
	--disable-directfb \
	--disable-zr \
	--disable-bl \
	--disable-tdfxvid \
	--disable-tga \
	--disable-pnm \
	--disable-md5sum
# Audio output: enable alsa
CONFIGURE_ARGS_AUDIO = \
	--enable-alsa \
	--disable-ossaudio \
	--disable-arts \
	--disable-esd \
	--disable-polyp \
	--disable-jack \
	--disable-openal \
	--disable-nas \
	--disable-sgiaudio \
	--disable-sunaudio \
	--disable-win32waveout \
	--disable-select
CONFIGURE_ARGS_MISC = \
	--enable-runtime-cpudetection \
	--enable-cross-compile \
	--cc="$(CC)" \
	--host-cc="$(build_CC)" \
	--as="$(AS)" \
	--target="$(GARCH_FAMILY)-linux" \
	--charset=noconv
CONFIGURE_ARGS_ADVANCED = \
	--enable-mmx \
	--enable-mmxext \
	--enable-3dnow \
	--enable-3dnowext \
	--enable-sse \
	--enable-sse2 \
	--enable-shm \
	--disable-altivec \
	--enable-fastmemcpy \
	--disable-big-endian \
	--disable-debug \
	--disable-profile \
	--enable-sighandler \
	--disable-crash-debug \
	--disable-dynamic-plugins
CONFIGURE_ARGS_WITH = \
	--with-extraincdir="$(DESTDIR)$(includedir)" \
	--with-extralibdir="$(DESTDIR)$(libdir)" \
	--with-x11libdir="$(DESTDIR)$(libdir)" \
	--with-codecsdir="$(libdir)/codecs" \
	--with-xvmclib=XvMCW \
	--with-freetype-config="$(DESTDIR)$(bindir)/freetype-config" \
	--with-sdl-config="$(DESTDIR)$(bindir)/sdl-config"
CONFIGURE_ARGS = \
	$(CONFIGURE_ARGS_DIR) \
	$(CONFIGURE_ARGS_OPTIONAL) \
	$(CONFIGURE_ARGS_CODEC) \
	$(CONFIGURE_ARGS_VIDEO) \
	$(CONFIGURE_ARGS_AUDIO) \
	$(CONFIGURE_ARGS_MISC) \
	$(CONFIGURE_ARGS_ADVANCED) \
	$(CONFIGURE_ARGS_WITH)
INSTALL_ARGS   = \
	STRIPBINARIES=

CONFIGURE_ENV  = \
	DESTDIR="$(DESTDIR)"
BUILD_ENV  = \
	DESTDIR="$(DESTDIR)"

include ../../gar.mk

CFLAGS :=

# When using the SVN version, GARVERSION must have the form <mplayer-svn-version>.<ffmpeg-svn-version>.
# This is done to ensure that the correct version of FFmpeg is used.
svn//%/$(DISTNAME).tar.bz2:
	@$(call FETCH_SVN, svn://$*/mplayer/trunk           , $(word 1,$(subst ., ,$(GARVERSION))), $(DISTNAME))
	@$(call FETCH_SVN, svn://$*/ffmpeg/trunk/libavutil  , $(word 2,$(subst ., ,$(GARVERSION))), libavutil  )
	@$(call FETCH_SVN, svn://$*/ffmpeg/trunk/libavcodec , $(word 2,$(subst ., ,$(GARVERSION))), libavcodec )
	@$(call FETCH_SVN, svn://$*/ffmpeg/trunk/libavformat, $(word 2,$(subst ., ,$(GARVERSION))), libavformat)
	@$(call FETCH_SVN, svn://$*/ffmpeg/trunk/libpostproc, $(word 2,$(subst ., ,$(GARVERSION))), libpostproc)
	@cd $(PARTIALDIR) ; tar -jxf $(DISTNAME).tar.bz2 ; rm -r $(DISTNAME).tar.bz2
	@cd $(PARTIALDIR) ; tar -jxf libavutil.tar.bz2   ; rm -r libavutil.tar.bz2   ; rm -rf $(DISTNAME)/libavutil   ; mv libavutil   $(DISTNAME)/
	@cd $(PARTIALDIR) ; tar -jxf libavcodec.tar.bz2  ; rm -r libavcodec.tar.bz2  ; rm -rf $(DISTNAME)/libavcodec  ; mv libavcodec  $(DISTNAME)/
	@cd $(PARTIALDIR) ; tar -jxf libavformat.tar.bz2 ; rm -r libavformat.tar.bz2 ; rm -rf $(DISTNAME)/libavformat ; mv libavformat $(DISTNAME)/
	@cd $(PARTIALDIR) ; tar -jxf libpostproc.tar.bz2 ; rm -r libpostproc.tar.bz2 ; rm -rf $(DISTNAME)/libpostproc ; mv libpostproc $(DISTNAME)/
	@cd $(PARTIALDIR) ; tar -jcf $(DISTNAME).tar.bz2 $(DISTNAME)
	@cd $(PARTIALDIR) ; rm -rf $(DISTNAME)
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

install-config:
	@mkdir -p $(DESTDIR)$(rootdir)/root/.mplayer
	@cp $(WORKSRC)/etc/codecs.conf  $(DESTDIR)$(rootdir)/root/.mplayer
	@cp $(WORKSRC)/etc/example.conf $(DESTDIR)$(rootdir)/root/.mplayer
	@cp $(WORKSRC)/etc/input.conf   $(DESTDIR)$(rootdir)/root/.mplayer
	@cp $(WORKSRC)/etc/menu.conf    $(DESTDIR)$(rootdir)/root/.mplayer
	@$(MAKECOOKIE)
