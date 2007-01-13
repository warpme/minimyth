GARNAME = MPlayer
GARVERSION = 1.0pre8
CATEGORIES = mediaplayers
MASTER_SITES  = http://www1.mplayerhq.hu/MPlayer/releases/
MASTER_SITES += http://www2.mplayerhq.hu/MPlayer/releases/
MASTER_SITES += http://www4.mplayerhq.hu/MPlayer/releases/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-openchrome.patch $(DISTNAME)-cross-$(GARCH_FAMILY).patch
LICENSE = mplayer
mplayer_LICENSE_TEXT = $(WORKSRC)/Copyright

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c kernel/linux lib/alsa-lib lib/cdparanoia lib/faad2 lib/libdvdread lib/libjpeg lib/libmad lib/libogg lib/libpng lib/libtheora lib/libvorbis lib/zlib lib/fontconfig lib/freetype xorg/xorg lib/SDL lirc/lirc

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
	--disable-tv-v4l \
	--disable-tv-v4l2 \
	--disable-tv-bsdbt848 \
	--enable-rtc \
	--enable-network \
	--disable-winsock2 \
	--disable-smb \
	--disable-live \
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
	$(if $(filter i386,$(GARCH_FAMILY)),--enable-dshow,--disable-dshow) \
	--disable-qtx \
	--enable-xanim \
	--enable-real \
	--disable-internal-tremor \
	--enable-vorbis \
	--enable-theora \
	--enable-external-faad \
	--disable-internal-faad \
	--enable-mad
# Video output: enable xv (requires x11 and vm) and xvmc
CONFIGURE_ARGS_VIDEO = \
	--disable-internal-vidix \
	--disable-external-vidix \
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
	--with-x11incdir="$(DESTDIR)$(includedir)" \
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

install-config:
	@mkdir -p $(DESTDIR)$(rootdir)/root/.mplayer
	@cp $(WORKSRC)/etc/codecs.conf  $(DESTDIR)$(rootdir)/root/.mplayer
	@cp $(WORKSRC)/etc/example.conf $(DESTDIR)$(rootdir)/root/.mplayer
	@cp $(WORKSRC)/etc/input.conf   $(DESTDIR)$(rootdir)/root/.mplayer
	@cp $(WORKSRC)/etc/menu.conf    $(DESTDIR)$(rootdir)/root/.mplayer
	@$(MAKECOOKIE)
