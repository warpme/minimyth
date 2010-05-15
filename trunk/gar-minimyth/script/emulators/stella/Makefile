GARNAME = stella
GARVERSION = 3.1.2
CATEGORIES = emulators
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME)-src.tar.gz
PATCHFILES = $(DISTNAME).patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/cxx lib/SDL lib/zlib xorg/xorg

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
	--enable-shared \
	--disable-static \
	--disable-profile \
	--with-zlib-prefix="$(DESTDIR)$(prefix)" \
	--x-libraries="$(DESTDIR)$(libdir)"

include ../../gar.mk

# stell 3.1.2 fails to compile with GCC 4.4.4's fgraphite-identity.
# However, it compiles with GCC 4.5.0.
CXXFLAGS := $(filter-out -fgraphite-identity, $(CXXFLAGS))
