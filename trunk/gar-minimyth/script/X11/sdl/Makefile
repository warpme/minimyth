GARNAME = SDL
GARVERSION = 1.2.8
CATEGORIES = X11
MASTER_SITES = http://www.libsdl.org/release/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-configure.patch $(DISTNAME)-DESTDIR.patch
LICENSE =

DESCRIPTION =
define BLURB
endef

DEPENDS   = lang/c X11/X11 lib/alsa-lib
BUILDDEPS = devel/nasm

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes=$(DESTDIR)$(x11includedir) \
	--x-libraries=$(DESTDIR)$(x11libdir) \
	--with-gnu-ld

include ../../gar.mk

post-install:
	@rm -rf $(DESTDIR)$(libdir)/libSDL.la
	@$(MAKECOOKIE)
