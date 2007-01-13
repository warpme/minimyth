GARNAME = SDL
GARVERSION = 1.2.9
CATEGORIES = X11
MASTER_SITES = http://www.libsdl.org/release/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-gcc4.patch $(DISTNAME).patch.gar
LICENSE =

DESCRIPTION =
define BLURB
endef

DEPENDS   = lang/c lib/alsa-lib xorg/xorg
BUILDDEPS = devel/nasm

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes=$(DESTDIR)$(x11includedir) \
	--x-libraries=$(DESTDIR)$(x11libdir) \
	--disable-debug \
	--disable-strict-ansi \
	--enable-audio \
	--enable-video \
	--enable-events \
	--disable-joystick \
	--disable-cdrom \
	--enable-threads \
	--enable-timers \
	--enable-endian \
	--enable-file \
	--enable-cpuinfo \
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
	--disable-mintaudio \
	--enable-nasm \
	--disable-video-nanox \
	--disable-nanox-debug \
	--disable-nanox-share-memory \
	--disable-nanox-direct-fb \
	--enable-video-x11 \
	--enable-video-x11-vm \
	--disable-dga \
	--disable-video-x11-dgamouse \
	--enable-video-x11-xv \
	--enable-video-x11-xinerama \
	--disable-video-x11-xme \
	--disable-video-dga \
	--disable-video-photon \
	--disable-video-fbcon \
	--disable-video-directfb \
	--disable-video-ps2gs \
	--disable-video-ggi \
	--disable-video-svga \
	--disable-video-vgl \
	--disable-video-aalib \
	--disable-video-xbios \
	--disable-video-gem \
	--disable-video-dummy \
	--enable-video-opengl \
	--enable-osmesa-shared \
	--enable-input-events \
	--enable-pth \
	--enable-pthreads \
	--enable-pthread-sem \
	--enable-sigaction \
	--disable-stdio-redirect \
	--disable-directx \
	--disable-video-qtopia \
	--disable-video-picogui \
	--enable-sdl-dlopen \
	--disable-atari-ldg \
	--disable-rpath \
	--with-gnu-ld \
	--with-x

include ../../gar.mk

post-install:
	@rm -rf $(DESTDIR)$(libdir)/libSDL.la
	@$(MAKECOOKIE)
