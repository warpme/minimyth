GARNAME = mednafen
GARVERSION = 0.8.C
CATEGORIES = emulators
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-gcc_4.5.0.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/alsa-lib lib/libcdio lib/libsndfile lib/SDL lib/SDL_net

WORKSRC = $(WORKDIR)/$(GARNAME)

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

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
	--enable-pce \
	--enable-pcfx \
	--enable-sms \
	--enable-wswan \
	--enable-alsa \
	--disable-alsatest \
	--disable-jack \
	--with-gnu-ld \
	--with-x \
	--without-libiconv-prefix \
	--without-libpth-prefix \
	--without-libintl-prefix

CONFIGURE_ENV = \
	SDL_CONFIG=$(DESTDIR)$(prefix)/bin-config/sdl-config

include ../../gar.mk

# mednafen 0.8.C fails to compile with GCC 4.4.4's fgraphite-identity.
CFLAGS := $(filter-out -fgraphite-identity, $(CFLAGS))

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)
