GARNAME = zsnes
GARVERSION = 1.42
CATEGORIES = emulators
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(GARNAME)$(subst .,,$(GARVERSION))src.tar.gz
PATCHFILES = $(DISTNAME).patch
LICENSE = LGPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c lib/libpng lib/SDL lib/zlib xorg/xorg
BUILDDEPS = devel/nasm

WORKSRC = $(WORKDIR)/$(GARNAME)_$(subst .,_,$(GARVERSION))

CONFIGURE_SCRIPTS = $(WORKSRC)/src/configure
BUILD_SCRIPTS     = $(WORKSRC)/src/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/src/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes="$(DESTDIR)$(incdludedir)" \
	--x-libraries="$(DESTDIR)$(libdir)" \
	--disable-sdltest \
	--enable-libpng  \
	--enable-opengl  \
	--with-sdl-prefix="$(DESTDIR)$(prefix)" \
	--with-sdl-exec-prefix="$(DESTDIR)$(prefix)" \
	--with-zlib-prefix="$(DESTDIR)$(prefix)" \
	--with-x

include ../../gar.mk

pre-configure:
	@cd $(WORKSRC)/src ; aclocal --verbose --install --force -I $(DESTDIR)$(datadir)/aclocal
	@cd $(WORKSRC)/src ; autoconf --verbose --force
	@$(MAKECOOKIE)
