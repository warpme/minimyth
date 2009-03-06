GARNAME = xine-lib
GARVERSION = 1.1.16.2
CATEGORIES = mediaplayers
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/xine/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-vdpau_svn_238.patch $(DISTNAME)-libtool_2.2.x.patch $(DISTNAME).patch.gar $(DISTNAME)-cross.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/alsa-lib lib/faad2 lib/ffmpeg lib/freetype lib/libcdio lib/libdca lib/libmad lib/libmng lib/libpng lib/vcdimager lib/zlib X11/vdpau xorg/xorg

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

# --without-external-dvdnav must be auto or internal dvdnav will work.
# Linux is only used for dha-kmod, which is disabled.
# Therefore, --with-linux-path is set to '/dev/null'.
CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--cache-file=config.cache \
	--x-includes="$(DESTDIR)$(includedir)" \
	--x-libraries="$(DESTDIR)$(libdir)" \
	--disable-static \
	--enable-shared \
	--disable-rpath \
	--enable-iconvtest \
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
	--disable-gnomevfs \
	--disable-gdkpixbuf \
	--disable-samba \
	--disable-dvdnavtest \
	--enable-vcd \
	--enable-asf \
	--enable-nosefart \
	--enable-faad \
	--enable-dts \
	--disable-modplug \
	--enable-real-codecs \
	--enable-mmap \
	--enable-antialiasing \
	--enable-largefile \
	--enable-optimizations \
	$(if $(filter i386,$(GARCH_FAMILY)),--enable-w32dll,--disable-w32dll) \
	--with-gnu-ld \
	$(if $(filter i386,$(GARCH_FAMILY)),--without-pic) \
	--without-libiconv-prefix \
	--without-libintl-prefix \
	--with-external-ffmpeg \
	--with-x \
	--without-zlib-prefix \
	--with-xv-path="$(DESTDIR)$(libdir)" \
	--with-xxmc-path="$(DESTDIR)$(libdir)" \
	--with-xxmc-lib=XvMCW \
	--with-xvmc-path="$(DESTDIR)$(libdir)" \
	--with-xvmc-lib=XvMCW \
	--with-vdpau \
	--without-xcb \
	--with-aalib-prefix="$(DESTDIR)$(prefix)" \
	--with-aalib-exec-prefix="$(DESTDIR)$(exec_prefix)" \
	--without-caca \
	--without-sdl \
	--without-libstk \
	--without-pulseaudio \
	--without-dxheaders \
	--with-libfame-prefix="$(DESTDIR)$(prefix)" \
	--with-libfame-exec-prefix="$(DESTDIR)$(exec_prefix)" \
	--with-linux-path="/dev/null" \
	--without-vorbis \
	--without-theora \
	--without-speex \
	--without-libflac \
	--without-external-a52dec \
	--with-external-libmad \
	--without-external-libmpcdec \
	--without-imagemagick \
	--with-freetype \
	--with-fontconfig \
	--with-alsa \
	--without-esound \
	--without-arts \
	--without-fusionsound \
	--without-jack \
	--without-internal-vcdlibs \
	--with-external-libdts \
	--without-wavpack \
	--with-real-codecs-path="$(libdir)/codecs" \
	--with-w32-path="$(libdir)/codecs" \
	--with-gnu-as

CONFIGURE_ENV = \
	lt_cv_path_MAGIC_CMD="$(build_DESTDIR)$(build_bindir)/file"

include ../../gar.mk

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(call FIX_LIBTOOL_LIBPATH,$(WORKSRC),configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libxine.la
	@$(MAKECOOKIE)

clean-all:
	@$(MAKE) -C ../xine-ui clean-all
