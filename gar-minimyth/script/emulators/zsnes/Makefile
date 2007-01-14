GARNAME = zsnes
GARVERSION = 4077
CATEGORIES = emulators
MASTER_SITES = svn://svn.bountysource.com/zsnes/trunk/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME).patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c lib/libpng lib/SDL lib/zlib xorg/xorg
BUILDDEPS = devel/nasm

CONFIGURE_SCRIPTS = $(WORKSRC)/src/configure
BUILD_SCRIPTS     = $(WORKSRC)/src/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/src/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes="$(DESTDIR)$(incdludedir)" \
	--x-libraries="$(DESTDIR)$(libdir)" \
	--disable-sdltest \
	--enable-libpng  \
	--disable-debugger \
	--enable-opengl  \
	--enable-jma \
	--disable-cpucheck \
	$(if $(filter yes,$(mm_DEBUG)),--enable-debug,--disable-debug) \
	$(if $(filter no,$(mm_DEBUG)),--enable-release,--disable-release) \
	--with-sdl-prefix="$(DESTDIR)$(prefix)" \
	--with-sdl-exec-prefix="$(DESTDIR)$(prefix)" \
	--with-x

CONFIGURE_ENV = \
	force_arch="$(GARCH)"

include ../../gar.mk

svn//%/$(DISTNAME).tar.bz2:
	@$(call FETCH_SVN, https://$*, $(GARVERSION), $(DISTNAME))
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

pre-configure:
	@cd $(WORKSRC)/src ; aclocal --verbose --install --force -I $(DESTDIR)$(datadir)/aclocal
	@cd $(WORKSRC)/src ; autoconf --verbose --force
	@$(MAKECOOKIE)
