GARNAME = transcode
GARVERSION = 1.0.2
CATEGORIES = utils
MASTER_SITES = http://www.jakemsr.com/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz config.cache.$(GARCH_FAMILY)
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/ffmpeg lib/libmpeg2 xorg/xorg

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--cache-file=config.cache \
	--x-include=$(DESTDIR)$(includedir) \
	--x-libraries=$(DESTDIR)$(libdir) \
	--enable-mmx \
	--enable-3dnow \
	--enable-sse \
	--enable-sse2 \
	--disable-altivec \
	--enable-shared \
	--enable-fast-install \
	--enable-libtool-lock \
	--disable-libavcodec-static \
	--enable-libavcodec \
	--enable-libmpeg2 \
	--enable-statbuffer \
	--disable-netstream \
	--disable-v4l \
	--disable-bktr \
	--disable-sunau \
	--disable-oss \
	--disable-ibp \
	--disable-libpostproc \
	--disable-freetype2 \
	--disable-avifile \
	--disable-lame \
	--disable-ogg \
	--disable-vorbis \
	--disable-theora \
	--disable-libdvdread \
	--disable-pvm3 \
	--disable-libdv \
	--disable-libquicktime \
	--disable-lzo \
	--disable-a52 \
	--disable-a52-default-decoder \
	--disable-libmpeg3 \
	--disable-libxml2 \
	--disable-mjpegtools \
	--disable-sdl \
	--disable-gtk \
	--disable-libfame \
	--disable-imagemagick \
	--disable-libjpegmmx \
	--disable-libjpeg \
	--disable-bsdav \
	--disable-iconv \
	--disable-xio \
	--disable-warnings-as-errors \
	--with-libavcodec-prefix=$(DESTDIR)$(prefix) \
	--with-libavcodec-includes=$(DESTDIR)$(includedir) \
	--with-libavcodec-libs=$(DESTDIR)$(libdir) \
	--with-libmpeg2-prefix=$(DESTDIR)$(prefix) \
	--with-libmpeg2-includes=$(DESTDIR)$(includecdir) \
	--with-libmpeg2-libs=$(DESTDIR)$(includedir) \
	--with-default-xvid=xvid4 \
	--with-libfdr=$(DESTDIR)$(prefix) \
	--with-libibp=$(DESTDIR)$(prefix) \
	--with-libexnode=$(DESTDIR)$(prefix) \
	--with-liblbone=$(DESTDIR)$(prefix) \
	--with-libend2end=$(DESTDIR)$(prefix) \
	--with-liblors=$(DESTDIR)$(prefix) \
	--with-libpostproc-prefix=$(DESTDIR)$(prefix) \
	--with-libpostproc-includes=$(DESTDIR)$(includedir) \
	--with-libpostproc-libs=$(DESTDIR)$(libdir) \
	--with-freetype2-prefix=$(DESTDIR)$(prefix) \
	--with-freetype2-includes=$(DESTDIR)$(includedir) \
	--with-freetype2-libs=$(DESTDIR)$(libdir) \
	--with-avifile-prefix=$(DESTDIR)$(prefix) \
	--with-avifile-includes=$(DESTDIR)$(includedir) \
	--with-avifile-libs=$(DESTDIR)$(libdir) \
	--with-lame-prefix=$(DESTDIR)$(prefix) \
	--with-lame-includes=$(DESTDIR)$(includedir) \
	--with-lame-libs=$(DESTDIR)$(libdir) \
	--with-ogg-prefix=$(DESTDIR)$(prefix) \
	--with-ogg-includes=$(DESTDIR)$(includedir) \
	--with-ogg-libs=$(DESTDIR)$(libdir) \
	--with-vorbis-prefix=$(DESTDIR)$(prefix) \
	--with-vorbis-includes=$(DESTDIR)$(includedir) \
	--with-vorbis-libs=$(DESTDIR)$(libdir) \
	--with-theora-prefix=$(DESTDIR)$(prefix) \
	--with-theora-includes=$(DESTDIR)$(includedir) \
	--with-theora-libs=$(DESTDIR)$(libdir) \
	--with-libdvdread-prefix=$(DESTDIR)$(prefix) \
	--with-libdvdread-includes=$(DESTDIR)$(includedir) \
	--with-libdvdread-libs=$(DESTDIR)$(libdir) \
	--with-pvm3-prefix=$(DESTDIR)$(prefix) \
	--with-pvm3-includes=$(DESTDIR)$(includedir) \
	--with-pvm3-libs=$(DESTDIR)$(libdir) \
	--with-libdv-prefix=$(DESTDIR)$(prefix) \
	--with-libdv-includes=$(DESTDIR)$(includedir) \
	--with-libdv-libs=$(DESTDIR)$(libdir) \
	--with-libquicktime-prefix=$(DESTDIR)$(prefix) \
	--with-libquicktime-includes=$(DESTDIR)$(includedir) \
	--with-libquicktime-libs=$(DESTDIR)$(libdir) \
	--with-lzo-prefix=$(DESTDIR)$(prefix) \
	--with-lzo-includes=$(DESTDIR)$(includedir) \
	--with-lzo-libs=$(DESTDIR)$(libdir) \
	--with-a52-prefix=$(DESTDIR)$(prefix) \
	--with-a52-includes=$(DESTDIR)$(includedir) \
	--with-a52-libs=$(DESTDIR)$(libdir) \
	--with-libmpeg3-prefix=$(DESTDIR)$(prefix) \
	--with-libmpeg3-includes=$(DESTDIR)$(includedir) \
	--with-libmpeg3-libs=$(DESTDIR)$(libdir) \
	--with-libxml2-prefix=$(DESTDIR)$(prefix) \
	--with-libxml2-includes=$(DESTDIR)$(includedir) \
	--with-libxml2-libs=$(DESTDIR)$(libdir) \
	--with-mjpegtools-prefix=$(DESTDIR)$(prefix) \
	--with-mjpegtools-includes=$(DESTDIR)$(includedir) \
	--with-mjpegtools-libs=$(DESTDIR)$(libdir) \
	--with-sdl-prefix=$(DESTDIR)$(prefix) \
	--with-sdl-includes=$(DESTDIR)$(includedir) \
	--with-sdl-libs=$(DESTDIR)$(libdir) \
	--with-gtk-prefix=$(DESTDIR)$(prefix) \
	--with-gtk-includes=$(DESTDIR)$(includedir) \
	--with-gtk-libs=$(DESTDIR)$(libdir) \
	--with-libfame-prefix=$(DESTDIR)$(prefix) \
	--with-libfame-includes=$(DESTDIR)$(includedir) \
	--with-libfame-libs=$(DESTDIR)$(libdir) \
	--with-imagemagick-prefix=$(DESTDIR)$(prefix) \
	--with-imagemagick-includes=$(DESTDIR)$(includedir) \
	--with-imagemagick-libs=$(DESTDIR)$(libdir) \
	--with-libjpegmmx-prefix=$(DESTDIR)$(prefix) \
	--with-libjpegmmx-includes=$(DESTDIR)$(includedir) \
	--with-libjpegmmx-libs=$(DESTDIR)$(libdir) \
	--with-libjpeg-prefix=$(DESTDIR)$(prefix) \
	--with-libjpeg-includes=$(DESTDIR)$(includedir) \
	--with-libjpeg-libs=$(DESTDIR)$(libdir) \
	--with-bsdav-prefix=$(DESTDIR)$(prefix) \
	--with-bsdav-includes=$(DESTDIR)$(includedir) \
	--with-bsdav-libs=$(DESTDIR)$(libdir) \
	--with-iconv-prefix=$(DESTDIR)$(prefix) \
	--with-iconv-includes=$(DESTDIR)$(includedir) \
	--with-iconv-libs=$(DESTDIR)$(libdir) \
	--with-mod-path=$(libdir)/transcode

include ../../gar.mk

extract-config.cache.$(GARCH_FAMILY):
	@cp $(DOWNLOADDIR)/config.cache.$(GARCH_FAMILY) $(WORKSRC)/config.cache
	@$(MAKECOOKIE)

pre-install:
	@rm -rf $(DESTDIR)$(libdir)/transcode
	@$(MAKECOOKIE)

post-install:
	@rm -rf $(DESTDIR)$(libdir)/transcode/*.la
	@$(MAKECOOKIE)
