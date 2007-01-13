GARNAME = xine-lib
GARVERSION = 1.0
CATEGORIES = myth
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/xine/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-DESTDIR.patch
LICENSE = 

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c kernel/linux lib/alsa-lib lib/flac lib/libmng lib/libogg lib/libpng lib/libvorbis X11/freetype X11/X11 X11/libXvMCW

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

# The configure program does not deal well with cross compiling,
# so we do not include --build or --host and we let CC set the compiler.
# Since both the the build and the host are i386, this works.
CONFIGURE_ARGS = $(DIRPATHS) \
	--cache-file=config.cache \
	--x-includes=$(DESTDIR)$(x11includedir) \
	--x-libraries=$(DESTDIR)$(x11libdir) \
	--disable-altivec \
	--disable-vis \
	--disable-mlib \
	--disable-ipv6 \
	--disable-fb \
	--disable-dxr3 \
	--disable-vidix \
	--disable-libFLACtest \
	--with-gnu-ld \
	--with-x \
	--with-xxmc-lib=XvMCW \
	--with-libFLAC-includes=$(DESTDIR)$(includedir) \
	--with-libFLAC-libraries=$(DESTDIR)$(libdir)

include ../../gar.mk

post-patch:
	@# Libtool wants to hardcode library paths. This stops that unwanted behavior.
	@sed -i 's%^hardcode_libdir_flag_spec=.*%hardcode_libdir_flag_spec=%' $(WORKSRC)/configure
	@# Libtool wants to modify the library run path. This stops that unwanted behavior.
	@sed -i 's%^runpath_var=.*%runpath_var=%' $(WORKSRC)/configure
	@# Libtool wants search system directories rather than DESTIMG directories. This stops that unwanted behavior.
	@sed -i 's%^sys_lib_dlsearch_path_spec=.*%sys_lib_dlsearch_path_spec=%' $(WORKSRC)/configure
	@sed -i 's%^sys_lib_search_path_spec=.*%sys_lib_search_path_spec=%' $(WORKSRC)/configure
	@$(MAKECOOKIE)

pre-configure:
	@echo "ac_cv_path_AALIB_CONFIG=no"                                     >  $(WORKSRC)/config.cache
	@echo "ac_cv_path_CACA_CONFIG=no"                                      >> $(WORKSRC)/config.cache
	@echo "ac_cv_path_SDL_CONFIG=$(DESTDIR)$(bindir)/sdl-config"           >> $(WORKSRC)/config.cache
	@echo "ac_cv_path_LIBFAME_CONFIG=no"                                   >> $(WORKSRC)/config.cache
	@echo "ac_cv_path_ESD_CONFIG=no"                                       >> $(WORKSRC)/config.cache
	@echo "ac_cv_path_ARTS_CONFIG=no"                                      >> $(WORKSRC)/config.cache
	@echo "ac_cv_path_DVDNAV_CONFIG=no"                                    >> $(WORKSRC)/config.cache
	@echo "ac_cv_path_LIBPNG_CONFIG=$(DESTDIR)$(bindir)/libpng-config"     >> $(WORKSRC)/config.cache
	@echo "ac_cv_path_FREETYPE_CONFIG=$(DESTDIR)$(bindir)/freetype-config" >> $(WORKSRC)/config.cache
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libxine.la
	@$(MAKECOOKIE)
