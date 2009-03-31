GARNAME = zsnes
GARVERSION = 1.51
CATEGORIES = emulators
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
#MASTER_SITES = svn://svn.bountysource.com/zsnes/trunk/
DISTFILES = $(GARNAME)$(subst .,,$(GARVERSION))src.tar.bz2
PATCHFILES = $(DISTNAME)-gcc_4.3.patch $(DISTNAME).patch
LICENSE = GPL2

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
	force_arch="$(GARCH)" \
	CC_FOR_BUILD="$(build_CC)" \
	CXX_FOR_BUILD="$(build_CXX)" \
	CPPFLAGS_FOR_BUILD="$(build_CPPFLAGS)" \
	CFLAGS_FOR_BUILD="$(build_CFLAGS)" \
	CXXFLAGS_FOR_BUILD="$(build_CXXFLAGS)" \
	LDFLAGS_FOR_BUILD="$(build_LDFLAGS)"

include ../../gar.mk

pre-configure:
	@cd $(WORKSRC)/src ; aclocal --verbose --force -I $(DESTDIR)$(datadir)/aclocal
	@cd $(WORKSRC)/src ; autoconf --verbose --force
	@$(MAKECOOKIE)
