GARNAME = xine-lib
GARVERSION = 1.1.3
CATEGORIES = mediaplayers
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/xine/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-flac.patch $(DISTNAME).patch.gar $(DISTNAME)-cross.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c kernel/kernel lib/alsa-lib lib/flac lib/libmng lib/libogg lib/libpng lib/libtheora lib/libvorbis lib/zlib lib/freetype xorg/xorg lib/SDL

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--cache-file=config.cache \
	--x-includes="$(DESTDIR)$(includedir)" \
	--x-libraries="$(DESTDIR)$(libdir)" \
	--disable-static \
	--enable-shared \
	--disable-rpath \
	--enable-nls \
	--enable-ffmpeg-uncommon-codecs \
	--enable-ffmpeg-popular-codecs \
	--disable-altivec \
	--disable-vis \
	--disable-mlib \
	--disable-mlib-lazyload \
	--disable-ipv6 \
	--enable-opengl \
	--enable-glu \
	--disable-syncfb \
	--disable-v4l \
	--disable-static-xv \
	--enable-xvmc \
	--enable-xinerama \
	--disable-aalib \
	--disable-aalibtest \
	--disable-fb \
	--disable-macosx-video \
	--disable-coreaudio \
	--disable-directfb \
	--disable-dxr3 \
	--disable-libfametest \
	--disable-vidix \
	--disable-dha-kmod \
	--disable-libFLACtest \
	--enable-a52dec \
	--enable-mad \
	--disable-musepack \
	--enable-mng \
	--disable-oss \
	--disable-artstest \
	--disable-jack \
	--disable-gnomevfs \
	--disable-gdkpixbuf \
	--disable-samba \
	--disable-dvdnavtest \
	--enable-vcd \
	--enable-asf \
	--enable-faad \
	--enable-dts \
	--disable-modplug \
	$(if $(filter i386,$(GARCH_FAMILY)),--enable-w32dll,--disable-w32dll) \
	--enable-mmap \
	--enable-antialiasing \
	--enable-largefile \
	--enable-optimizations \
	--with-gnu-ld \
	--without-libiconv-prefix \
	--without-libintl-prefix \
	--without-pthread-prefix \
	--without-external-ffmpeg \
	--with-x \
	--without-zlib-prefix \
	--without-xv-path \
	--without-xxmc-path \
	--with-xxmc-lib=XvMCW \
	--without-xvmc-path \
	--with-xvmc-lib=XvMCW \
	--with-aalib-prefix="$(DESTDIR)$(prefix)" \
	--with-aalib-exec-prefix="$(DESTDIR)$(exec_prefix)" \
	--without-caca \
	--with-sdl \
	--without-pulseaudio \
	--without-dxheaders \
	--with-libfame-prefix="$(DESTDIR)$(prefix)" \
	--with-libfame-exec-prefix="$(DESTDIR)$(exec_prefix)" \
	--with-linux-path="$(DESTDIR)$(LINUX_SOURCEDIR)" \
	--with-vorbis \
	--with-theora \
	--without-speex \
	--enable-flac \
	--with-libFLAC-prefix="$(DESTDIR)$(prefix)" \
	--with-libFLAC-includes="$(DESTDIR)$(includedir)" \
	--with-libFLAC-libraries="$(DESTDIR)$(libdir)" \
	--without-external-a52dec \
	--without-external-libmad \
	--without-external-libmpcdec \
	--without-imagemagick \
	--with-freetype \
	--with-fontconfig \
	--with-alsa \
	--without-esound \
	--without-arts \
	--without-fusionsound \
	--with-internal-vcdlibs \
	--without-external-libdts \
	--without-wavpack \
	--with-w32-path="$(libdir)/codecs"

CONFIGURE_ENV = \
	lt_cv_path_MAGIC_CMD="$(build_DESTDIR)$(build_bindir)/file"

GAR_EXTRA_CONF += kernel-$(mm_KERNEL_VERSION)/linux/package-api.mk
include ../../gar.mk

pre-configure:
	@cd $(WORKSRC) ; ACLOCAL=aclocal-1.9 AUTOMAKE=automake-1.9 autoreconf --verbose --install --force
	@# Libtool wants to hardcode library paths. This stops that unwanted behavior.
	@sed -i 's%^hardcode_libdir_flag_spec=.*%hardcode_libdir_flag_spec=%' $(WORKSRC)/configure
	@# Libtool wants to modify the library run path. This stops that unwanted behavior.
	@sed -i 's%^runpath_var=.*%runpath_var=%' $(WORKSRC)/configure
	@# Libtool wants search system directories rather than DESTIMG directories. This stops that unwanted behavior.
	@sed -i 's%^sys_lib_dlsearch_path_spec=.*%sys_lib_dlsearch_path_spec=%' $(WORKSRC)/configure
	@sed -i 's%^sys_lib_search_path_spec=.*%sys_lib_search_path_spec=%' $(WORKSRC)/configure
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libxine.la
	@sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'         $(DESTDIR)$(libdir)/pkgconfig/libxine.pc
	@sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g' $(DESTDIR)$(libdir)/pkgconfig/libxine.pc
	@$(MAKECOOKIE)

clean-all:
	@$(MAKE) -C ../xine-ui clean-all
