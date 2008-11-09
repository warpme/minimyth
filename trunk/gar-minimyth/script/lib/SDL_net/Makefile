GARNAME = SDL_net
GARVERSION = 1.2.7
CATEGORIES = lib
MASTER_SITES = http://www.libsdl.org/projects/$(GARNAME)/release/
DISTFILES = $(DISTNAME).tar.gz
#PATCHFILES = $(DISTNAME).patch.gar
LICENSE = LGPL2_1

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/SDL

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-shared \
	--disable-static \
	--disable-sdltest \
	--disable-gui \
	--with-gnu-ld \
	--with-sdl-prefix="$(DESTDIR)$(prefix)" \
	--with-sdl-exec-prefix="$(DESTDIR)$(prefix)"

include ../../gar.mk

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -rf $(DESTDIR)$(libdir)/libSDL_net.la
	@$(MAKECOOKIE)
