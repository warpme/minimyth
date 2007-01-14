GARNAME = xine-lib
GARVERSION = 1.1.1
CATEGORIES = mediaplayers
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/xine/
DISTFILES = \
	$(if $(filter 1.1.1,$(GARVERSION)),$(DISTNAME).tar.gz ) \
	$(if $(filter 1.1.2,$(GARVERSION)),$(DISTNAME).tar.bz2)
PATCHFILES  = $(DISTNAME).patch.gar $(DISTNAME)-cross.patch $(DISTNAME)-alsa_configure.patch
PATCHFILES += $(if $(filter 1.1.1,$(GARVERSION)),$(DISTNAME)-xxmc_subpicture.patch)
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c kernel/linux lib/alsa-lib lib/flac lib/libmng lib/libogg lib/libpng lib/libtheora lib/libvorbis lib/zlib lib/freetype xorg/xorg lib/SDL

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(CONFIGURE_ARGS_$(GARVERSION))

CONFIGURE_ARGS_1.1.1 = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--cache-file=config.cache \
	--x-includes="$(DESTDIR)$(includedir)" \
	--x-libraries="$(DESTDIR)$(libdir)" \
	--disable-static \
	--enable-shared \
	--enable-nls \
	--disable-altivec \
	--disable-vis \
	--disable-mlib \
	--disable-mlib-lazyload \
	--disable-ffmpegtest \
	--disable-ipv6 \
	--enable-opengl \
	--enable-glu \
	--disable-fb \
	--disable-v4l \
	--disable-static-xv \
	--enable-xinerama \
	--disable-aalib \
	--disable-aalibtest \
	--disable-caca \
	--disable-cacatest \
	--disable-fb \
	--disable-macosx-video \
	--disable-coreaudio \
	--disable-directfb \
	--enable-sdl \
	--disable-sdltest \
	--disable-polypaudio \
	--disable-dxr3 \
	--disable-libfametest \
	--disable-vidix \
	--disable-dha-kmod \
	--disable-oggtest \
	--disable-vorbistest \
	--disable-theoratest \
	--disable-speex \
	--enable-flac \
	--disable-libFLACtest \
	--enable-a52dec \
	--enable-mad \
	--enable-mng \
	--disable-imagemagick \
	--enable-freetype \
	--disable-oss \
	--enable-alsa \
	--enable-alsatest \
	--disable-esd \
	--disable-esdtest \
	--disable-arts \
	--disable-artstest \
	--disable-gnome \
	--disable-samba \
	--disable-dvdnavtest \
	--enable-vcd \
	--enable-asf \
	--enable-faad \
	--enable-dts \
	--enable-largefile \
	--enable-optimizations \
	--enable-min-symtab \
	--with-gnu-ld \
	--with-x \
	--with-xvmc-lib=XvMCW \
	--with-xxmc-lib=XvMCW \
	--with-libFLAC-includes="$(DESTDIR)$(includedir)" \
	--with-libFLAC-libraries="$(DESTDIR)$(libdir)" \
	--with-w32-path="$(libdir)/codecs"

CONFIGURE_ARGS_1.1.2 = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--cache-file=config.cache \
	--x-includes="$(DESTDIR)$(includedir)" \
	--x-libraries="$(DESTDIR)$(libdir)" \
	--disable-static \
	--enable-shared \
	--disable-rpath \
	--enable-nls \
	--disable-altivec \
	--disable-vis \
	--disable-mlib \
	--disable-mlib-lazyload \
	--disable-ffmpegtest \
	--disable-ipv6 \
	--enable-opengl \
	--enable-glu \
	--disable-fb \
	--disable-v4l \
	--disable-static-xv \
	--enable-xvmc \
	--enable-xinerama \
	--disable-aalib \
	--disable-aalibtest \
	--disable-caca \
	--disable-cacatest \
	--disable-fb \
	--disable-macosx-video \
	--disable-coreaudio \
	--disable-directfb \
	--enable-sdl \
	--disable-sdltest \
	--disable-polypaudio \
	--disable-dxr3 \
	--disable-libfametest \
	--disable-vidix \
	--disable-dha-kmod \
	--disable-oggtest \
	--disable-vorbistest \
	--disable-theoratest \
	--disable-speex \
	--enable-flac \
	--disable-libFLACtest \
	--enable-a52dec \
	--enable-mad \
	--enable-mng \
	--disable-imagemagick \
	--enable-freetype \
	--disable-oss \
	--enable-alsa \
	--enable-alsatest \
	--disable-esd \
	--disable-esdtest \
	--disable-arts \
	--disable-artstest \
	--disable-fusionsound \
	--disable-gnomevfs \
	--disable-samba \
	--disable-dvdnavtest \
	--enable-vcd \
	--enable-asf \
	--enable-faad \
	--enable-dts \
	--disable-modplug \
	$(if $(filter i386,$(GARCH_FAMILY)),--enable-w32dll,--disable-w32dll) \
	--enable-largefile \
	--enable-optimizations \
	--enable-min-symtab \
	--with-gnu-ld \
	--with-x \
	--with-xvmc-lib=XvMCW \
	--with-xxmc-lib=XvMCW \
	--with-aalib-prefix="$(DESTDIR)$(prefix)" \
	--with-aalib-exec-prefix="$(DESTDIR)$(exec_prefix)" \
	--with-caca-prefix="$(DESTDIR)$(prefix)" \
	--with-caca-exec-prefix="$(DESTDIR)$(exec_prefix)" \
	--with-sdl-prefix="$(DESTDIR)$(prefix)" \
	--with-sdl-exec-prefix="$(DESTDIR)$(exec_prefix)" \
	--with-libfame-prefix="$(DESTDIR)$(prefix)" \
	--with-libfame-exec-prefix="$(DESTDIR)$(exec_prefix)" \
	--with-linux-path="$(KERNEL_SOURCEDIR)" \
	--with-libFLAC-includes="$(DESTDIR)$(includedir)" \
	--with-libFLAC-libraries="$(DESTDIR)$(libdir)" \
	--with-alsa-prefix="$(DESTDIR)$(prefix)" \
	--with-alsa-exec-prefix="$(DESTDIR)$(exec_prefix)" \
	--with-esd-prefix="$(DESTDIR)$(prefix)" \
	--with-esd-exec-prefix="$(DESTDIR)$(exec_prefix)" \
	--with-arts-prefix="$(DESTDIR)$(prefix)" \
	--with-w32-path="$(libdir)/codecs"

GAR_EXTRA_CONF += kernel/linux/package-api.mk
include ../../gar.mk

pre-configure: pre-configure-$(GARVERSION)

pre-configure-1.1.1:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@# Libtool wants to hardcode library paths. This stops that unwanted behavior.
	@sed -i 's%^hardcode_libdir_flag_spec=.*%hardcode_libdir_flag_spec=%' $(WORKSRC)/configure
	@# Libtool wants to modify the library run path. This stops that unwanted behavior.
	@sed -i 's%^runpath_var=.*%runpath_var=%' $(WORKSRC)/configure
	@# Libtool wants search system directories rather than DESTIMG directories. This stops that unwanted behavior.
	@sed -i 's%^sys_lib_dlsearch_path_spec=.*%sys_lib_dlsearch_path_spec=%' $(WORKSRC)/configure
	@sed -i 's%^sys_lib_search_path_spec=.*%sys_lib_search_path_spec=%' $(WORKSRC)/configure
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

pre-configure-1.1.2:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@# Libtool wants to hardcode library paths. This stops that unwanted behavior.
	@sed -i 's%^hardcode_libdir_flag_spec=.*%hardcode_libdir_flag_spec=%' $(WORKSRC)/configure
	@# Libtool wants to modify the library run path. This stops that unwanted behavior.
	@sed -i 's%^runpath_var=.*%runpath_var=%' $(WORKSRC)/configure
	@# Libtool wants search system directories rather than DESTIMG directories. This stops that unwanted behavior.
	@sed -i 's%^sys_lib_dlsearch_path_spec=.*%sys_lib_dlsearch_path_spec=%' $(WORKSRC)/configure
	@sed -i 's%^sys_lib_search_path_spec=.*%sys_lib_search_path_spec=%' $(WORKSRC)/configure
	@echo "ac_cv_path_AALIB_CONFIG=no"                                     >  $(WORKSRC)/config.cache
	@echo "ac_cv_path_CACA_CONFIG=no"                                      >> $(WORKSRC)/config.cache
	@echo "ac_cv_path_SDL_CONFIG=$(DESTDIR)$(bindir)/sdl-config"           >> $(WORKSRC)/config.cache
	@echo "ac_cv_path_LIBFAME_CONFIG=no"                                   >> $(WORKSRC)/config.cache
	@echo "ac_cv_path_WAND_CONFIG=no"                                      >> $(WORKSRC)/config.cache
	@echo "ac_cv_path_FREETYPE_CONFIG=$(DESTDIR)$(bindir)/freetype-config" >> $(WORKSRC)/config.cache
	@echo "ac_cv_path_ESD_CONFIG=no"                                       >> $(WORKSRC)/config.cache
	@echo "ac_cv_path_ARTS_CONFIG=no"                                      >> $(WORKSRC)/config.cache
	@echo "ac_cv_path_DVDNAV_CONFIG=no"                                    >> $(WORKSRC)/config.cache
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libxine.la
	@sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'         $(DESTDIR)$(libdir)/pkgconfig/libxine.pc
	@sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g' $(DESTDIR)$(libdir)/pkgconfig/libxine.pc
	@$(MAKECOOKIE)

clean-all:
	@$(MAKE) clean
	@rm -rf $(DESTDIR)$(bindir)/xine-config
	@rm -rf $(DESTDIR)$(includedir)/xine
	@rm -rf $(DESTDIR)$(includedir)/xine.h
	@rm -rf $(DESTDIR)$(libdir)/xine
	@rm -rf $(DESTDIR)$(libdir)/libxine.*
	@rm -rf $(DESTDIR)$(datadir)/xine
	@rm -rf $(DESTDIR)$(docdir)/xine
