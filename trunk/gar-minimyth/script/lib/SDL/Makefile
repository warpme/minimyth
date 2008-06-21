GARNAME = SDL
GARVERSION = 1.2.13
CATEGORIES = lib
MASTER_SITES = http://www.libsdl.org/release/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME).patch.gar
LICENSE = LGPL2_1

DESCRIPTION =
define BLURB
endef

DEPENDS    = lang/c lib/alsa-lib xorg/xorg
BUILDDEPS  = devel/yasm

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes=$(DESTDIR)$(includedir) \
	--x-libraries=$(DESTDIR)$(libdir) \
	--enable-libc \
	--enable-audio \
	--enable-video \
	--enable-events \
	--enable-joystick \
	--disable-cdrom \
	--enable-threads \
	--enable-timers \
	--enable-file \
	--enable-loadso \
	--enable-cpuinfo \
	--enable-assembly \
	--disable-oss \
	--enable-alsa \
	--enable-alsatest \
	--enable-alsa-shared \
	--disable-esd \
	--disable-esdtest \
	--disable-esd-shared \
	--disable-arts \
	--disable-arts-shared \
	--disable-nas \
	--disable-diskaudio \
	--disable-dummyaudio \
	--disable-mintaudio \
	--enable-nasm \
	--disable-altivec \
	--disable-ipod \
	--disable-video-nanox \
	--disable-nanox-debug \
	--disable-nanox-share-memory \
	--disable-nanox-direct-fb \
	--enable-video-x11 \
	--enable-x11-shared \
	--disable-dga \
	--disable-video-dga \
	--disable-video-x11-dgamouse \
	--enable-video-x11-vm \
	--enable-video-x11-xv \
	--enable-video-x11-xinerama \
	--disable-video-x11-xme \
	--enable-video-x11-xrandr \
	--disable-video-dpms \
	--disable-video-photon \
	--disable-video-carbon \
	--disable-video-cocoa \
	--disable-video-fbcon \
	--disable-video-directfb \
	--disable-video-ps2gs \
	--disable-video-ggi \
	--disable-video-svga \
	--disable-video-vgl \
	--enable-video-wscons \
	--disable-video-aalib \
	--disable-video-qtopia \
	--disable-video-picogui \
	--disable-video-xbios \
	--disable-video-gem \
	--disable-video-dummy \
	--enable-video-opengl \
	--enable-osmesa-shared \
	--enable-input-events \
	--disable-input-tslib \
	--enable-pth \
	--enable-pthreads \
	--enable-pthread-sem \
	--disable-stdio-redirect \
	--disable-directx \
	--enable-sdl-dlopen \
	--disable-atari-ldg \
	--disable-clock_gettime \
	--disable-rpath \
	--with-gnu-ld \
	--with-x

include ../../gar.mk

pre-configure:
	@$(call FIX_LIBTOOL_LIBPATH,$(WORKSRC),configure)
	@$(MAKECOOKIE)

post-install:
	@rm -rf $(DESTDIR)$(libdir)/libSDL.la
	@$(MAKECOOKIE)
