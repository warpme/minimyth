GARNAME = MPlayer
GARVERSION = 1.0pre6a
CATEGORIES = myth
MASTER_SITES  = http://ftp5.mplayerhq.hu/mplayer/releases/
MASTER_SITES += http://internap.dl.sourceforge.net/sourceforge/unichrome/
DISTFILES = $(GARNAME)-$(GARVERSION).tar.bz2
PATCHFILES = $(GARNAME)-$(GARVERSION)-unichrome-0.5.bz2 $(GARNAME)-$(GARVERSION)-c3.patch $(GARNAME)-$(GARVERSION)-host.patch
LICENSE = mplayer
mplayer_LICENSE_TEXT = $(WORKSRC)/Copyright

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c kernel/linux lib/alsa-lib lib/cdparanoia lib/libdvdread lib/libmad X11/fontconfig X11/freetype X11/X11 lirc/lirc

PATCHDIR = $(WORKSRC)

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
	--enable-linux-devfs \
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
	--disable-network \
	--disable-live \
	--enable-dvdread \
	--disable-mpdvdkit \
	--enable-cdparanoia \
	--enable-freetype \
	--enable-fontconfig \
	--enable-menu
# Codecs
CONFIGURE_ARGS_CODEC = \
	--disable-gif \
	--disable-png \
	--disable-jpeg \
	--disable-win32 \
	--disable-xanim \
	--disable-real \
	--disable-vorbis \
	--disable-internal-matroska \
	--enable-mad
# Video output: enable xv (requires x11 and vm) and xxmc
CONFIGURE_ARGS_VIDEO = \
	--disable-vidix \
	--disable-gl \
	--disable-dga \
	--disable-vesa \
	--disable-svga \
	--disable-sdl \
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
	--disable-xvmc \
	--enable-xxmc \
	--enable-vm \
	--disable-xinerama \
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
	--disable-alsa \
	--enable-ossaudio \
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
	--target="$(GARCH)-linux"
CONFIGURE_ARGS_ADVANCED = \
	--$(if $(filter, $(GARCH), c3 c3-2),enable,disable)-mmx \
	--disable-mmx2 \
	--$(if $(filter, $(GARCH), c3     ),enable,disable)-3dnow \
	--disable-3dnowex \
	--$(if $(filter, $(GARCH),    c3-2),enable,disable)-sse \
	--disable-sse2 \
	--disable-shm \
	--disable-altivec \
	--disable-fastmemcpy \
	--disable-big-endian
CONFIGURE_ARGS_WITH = \
	--with-x11incdir="$(DESTDIR)$(x11includedir)" \
	--with-x11libdir="$(DESTDIR)$(x11libdir)" \
	--with-freetype-config="$(DESTDIR)$(bindir)/freetype-config"
CONFIGURE_ARGS = \
	$(CONFIGURE_ARGS_DIR) \
	$(CONFIGURE_ARGS_OPTIONAL) \
	$(CONFIGURE_ARGS_CODEC) \
	$(CONFIGURE_ARGS_VIDEO) \
	$(CONFIGURE_ARGS_AUDIO) \
	$(CONFIGURE_ARGS_MISC) \
	$(CONFIGURE_ARGS_ADVANCED) \
	$(CONFIGURE_ARGS_WITH)

CONFIGURE_ENV  = \
	PKG_CONFIG_PATH="$(DESTDIR)$(libdir)/pkgconfig:$(DESTDIR)$(x11libdir)/pkgconfig:$(DESTDIR)$(qtlibdir)/pkgconfig" \
	DESTDIR="$(DESTDIR)"
BUILD_ENV  = \
	PKG_CONFIG_PATH="$(DESTDIR)$(libdir)/pkgconfig:$(DESTDIR)$(x11libdir)/pkgconfig:$(DESTDIR)$(qtlibdir)/pkgconfig" \
	DESTDIR="$(DESTDIR)"

GAR_EXTRA_CONF += myth/mplayer/configure.mk
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
