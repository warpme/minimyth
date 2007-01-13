GARNAME = MPlayer
GARVERSION = 1.0pre7try2
CATEGORIES = mediaplayers
MASTER_SITES = http://www.mplayerhq.hu/MPlayer/releases/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-demuxer_h.patch $(DISTNAME)-gcc4.patch $(DISTNAME)-unichrome.patch $(DISTNAME)-xvmc_fallback.patch $(DISTNAME)-cross-$(GARCH_FAMILY).patch
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
	--datadir="$(datadir)" \
	--mandir="$(mandir)" \
	--confdir="$(sysconfdir)" \
	--libdir="$(libdir)"
# Optional features
CONFIGURE_ARGS_OPTIONAL = \
	--disable-mencoder \
	--disable-gui \
	--enable-largefiles \
	--disable-termcap \
	--disable-termios \
	--enable-iconv \
	--enable-lirc \
	--disable-tv \
	--disable-tv-v4l \
	--disable-tv-v4l2 \
	--disable-tv-bsdbt848 \
	--enable-rtc \
	--disable-edl \
	--enable-network \
	--disable-smb \
	--disable-live \
	--enable-dvdread \
	--disable-mpdvdkit \
	--enable-cdparanoia \
	--enable-freetype \
	--enable-fontconfig \
	--enable-menu \
	--disable-inet6
# Codecs
CONFIGURE_ARGS_CODEC = \
	--disable-gif \
	--enable-png \
	--enable-jpeg \
	--disable-win32 \
	$(if $(filter i386,$(GARCH_FAMILY)),--enable-win32,--disable-win32) \
	--enable-xanim \
	--enable-real \
	--disable-internal-tremor \
	--enable-vorbis \
	--enable-theora \
	--enable-internal-matroska \
	--enable-external-faad \
	--disable-internal-faad \
	--enable-mad
# Video output: enable xv (requires x11 and vm) and xxmc
CONFIGURE_ARGS_VIDEO = \
	--disable-vidix \
	--enable-gl \
	--disable-dga \
	--disable-vesa \
	--disable-svga \
	--enable-sdl \
	--disable-aa \
	--disable-caca \
	--disable-ggi \
	--disable-directx \
	--disable-dxr2 \
	--disable-dxr3 \
	--disable-dvb \
	--disable-dvbhead \
	--disable-mga \
	--disable-xmga \
	--enable-xv \
	--enable-xvmc \
	--enable-xxmc \
	--enable-vm \
	--enable-xinerama \
	--enable-x11 \
	--disable-fbdev \
	--disable-mlib \
	--disable-3dfx \
	--disable-tdfxfb \
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
	--target="$(GARCH_FAMILY)-linux"
CONFIGURE_ARGS_ADVANCED = \
	--enable-mmx \
	--enable-mmx2 \
	--enable-3dnow \
	--enable-3dnowex \
	--enable-sse \
	--enable-sse2 \
	--enable-shm \
	--disable-altivec \
	--enable-fastmemcpy \
	--disable-big-endian
CONFIGURE_ARGS_WITH = \
	--with-x11incdir="$(DESTDIR)$(includedir)" \
	--with-x11libdir="$(DESTDIR)$(libdir)" \
	--with-codecsdir="$(libdir)/codecs" \
	--with-xvmclib=XvMCW \
	--with-xxmclib=XvMCW \
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

post-patch:
	@sed -i 's%\([ \t]*\)ldconfig%\1true%' $(WORKSRC)/libdha/Makefile
	@$(MAKECOOKIE)

install-config:
	@mkdir -p $(DESTDIR)$(rootdir)/root/.mplayer
	@cp $(WORKSRC)/etc/codecs.conf  $(DESTDIR)$(rootdir)/root/.mplayer
	@cp $(WORKSRC)/etc/example.conf $(DESTDIR)$(rootdir)/root/.mplayer
	@cp $(WORKSRC)/etc/input.conf   $(DESTDIR)$(rootdir)/root/.mplayer
	@cp $(WORKSRC)/etc/menu.conf    $(DESTDIR)$(rootdir)/root/.mplayer
	@$(MAKECOOKIE)
