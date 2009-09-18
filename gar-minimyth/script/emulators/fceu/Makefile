GARNAME = fceu
GARVERSION = 0.98.13-pre
CATEGORIES = emulators
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/fceultra/
DISTFILES = $(DISTNAME).src.tar.bz2
PATCHFILES = $(DISTNAME)-fixes.patch $(DISTNAME)-sdl_sound.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/SDL

WORKSRC = $(WORKDIR)/$(GARNAME)

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-sdltest \
	--without-debugger \
	--without-nativewin32 \
	--with-opengl

include ../../gar.mk

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(MAKECOOKIE)
