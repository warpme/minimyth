GARNAME = stella
GARVERSION = 2.2
CATEGORIES = emulators
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME)-src.tar.gz
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c lib/libpng lib/SDL lib/zlib xorg/xorg
BUILDDEPS = devel/nasm

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = \
	--prefix="$(prefix)" \
	--bindir="$(bindir)" \
	--docdir="$(docdir)/stella" \
	--datadir="$(datadir)" \
	--enable-gl \
	--enable-sound \
	--disable-developer \
	--enable-snapshot \
	--enable-joystick \
	--enable-cheats \
	--enable-shared \
	--disable-static \
	--disable-profile \
	--enable-zlib \
	--enable-png \
	--with-sdl-prefix="$(DESTDIR)$(prefix)" \
	--enable-nasm \
	--x-libraries="$(DESTDIR)$(libdir)"

include ../../gar.mk
