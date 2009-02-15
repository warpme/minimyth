GARNAME = stella
GARVERSION = 2.7.3
CATEGORIES = emulators
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME)-src.tar.gz
PATCHFILES = $(DISTNAME).patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/SDL lib/zlib xorg/xorg

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = \
	--prefix="$(prefix)" \
	--bindir="$(bindir)" \
	--docdir="$(docdir)/stella" \
	--datadir="$(datadir)" \
	--enable-gl \
	--enable-windowed \
	--enable-sound \
	--enable-debugger \
	--enable-joystick \
	--enable-cheats \
	--disable-speakjet \
	--enable-shared \
	--disable-static \
	--disable-profile \
	--with-sdl-prefix="$(DESTDIR)$(prefix)" \
	--with-zlib-prefix="$(DESTDIR)$(prefix)" \
	--x-libraries="$(DESTDIR)$(libdir)"

include ../../gar.mk
