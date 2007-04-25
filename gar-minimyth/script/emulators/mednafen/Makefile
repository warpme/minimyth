GARNAME = mednafen
GARVERSION = 0.8.1
CATEGORIES = emulators
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/alsa-lib lib/libsndfile lib/SDL lib/SDL_net

WORKSRC = $(WORKDIR)/$(GARNAME)

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

# pce, pcfx and wswan require libcdio, which the build system does not have because it does not cross compile.
# Therefore, pce, pcfx and wswan are disabled.
# LIBCDIO_CFLAGS and LIBCDIO_LIBS are set in order to fool the configure script.
CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes="$(DESTDIR)$(includedir)" \
	--x-libraries="$(DESTDIR)$(libdir)" \
	--disable-rath \
	--enable-nls \
	--enable-threads=posix \
	--disable-debugger \
	--disable-cjk-fonts \
	--enable-gb \
	--enable-gba \
	--enable-lynx \
	--enable-nes \
	--enable-ngp \
	--disable-pce \
	--disable-pcfx \
	--disable-wswan \
	--enable-alsa \
	--disable-alsatest \
	--disable-jack \
	--with-gnu-ld \
	--with-x \
	--without-libiconv-prefix \
	--without-libpth-prefix \
	--without-libintl-prefix \
	--with-alsa-prefix="$(DESTDIR)$(prefix)" \
	--with-sdl-prefix="$(DESTDIR)$(prefix)" \
	--with-sdl-exec-prefix="$(DESTDIR)$(prefix)"
	
CONFIGURE_ENV = \
	LIBCDIO_CFLAGS="-I$(DESTDIR)$(includedir)" \
	LIBCDIO_LIBS="-L$(DESTDIR)$(libdir)"

include ../../gar.mk

x-pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(MAKECOOKIE)
