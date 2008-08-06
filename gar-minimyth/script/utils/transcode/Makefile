GARNAME = transcode
GARVERSION = 1.0.6
CATEGORIES = utils
MASTER_SITES  = http://fromani.exit1.org/
MASTER_SITES += http://www.kraymer.mynetcologne.de/
DISTFILES = $(DISTNAME).tar.bz2 config.cache.$(GARCH_FAMILY)
PATCHFILES = $(DISTNAME)-configure.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/a52dec lib/ffmpeg lib/freetype lib/lame lib/lzo lib/mpeg2dec lib/xvidcore xorg/xorg

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--cache-file=config.cache \
	--x-include=$(DESTDIR)$(includedir) \
	--x-libraries=$(DESTDIR)$(libdir) \
	--disable-static \
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
	--enable-lame \
	--disable-ogg \
	--disable-vorbis \
	--disable-theora \
	--disable-libdvdread \
	--disable-pvm3 \
	--disable-libdv \
	--disable-libquicktime \
	--enable-lzo \
	--enable-a52 \
	--enable-a52-default-decoder \
	--disable-libmpeg3 \
	--disable-libxml2 \
	--disable-mjpegtools \
	--disable-sdl \
	--disable-libfame \
	--disable-imagemagick \
	--disable-libjpegmmx \
	--disable-libjpeg \
	--disable-bsdav \
	--disable-iconv \
	--disable-xio \
	--disable-warnings-as-errors \
	--with-gnu-ld \
	--with-x \
	--with-libavcodec-includes=$(PKG_CONFIG_SYSROOT_DIR)`pkg-config --variable=includedir libavcodec` \
	--with-libavcodec-libs=$(PKG_CONFIG_SYSROOT_DIR)`pkg-config --variable=includedir libavcodec` \
	--with-libpostproc-includes=$(PKG_CONFIG_SYSROOT_DIR)`pkg-config --variable=includedir libpostproc` \
	--with-libpostproc-libs=$(PKG_CONFIG_SYSROOT_DIR)`pkg-config --variable=includedir libpostproc` \
	--with-default-xvid=xvid4 \
	--with-lame-prefix=$(DESTDIR)$(prefix) \
	--with-lame-includes=$(DESTDIR)$(includedir) \
	--with-lame-libs=$(DESTDIR)$(libdir) \
	--with-mod-path=$(libdir)/transcode

include ../../gar.mk

CFLAGS += `pkg-config --cflags libavcodec` `pkg-config --libs libavcodec`

extract-config.cache.$(GARCH_FAMILY):
	@cp $(DOWNLOADDIR)/config.cache.$(GARCH_FAMILY) $(WORKSRC)/config.cache
	@$(MAKECOOKIE)

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

pre-install:
	@rm -rf $(DESTDIR)$(libdir)/transcode
	@$(MAKECOOKIE)

post-install:
	@rm -rf $(DESTDIR)$(libdir)/transcode/*.la
	@$(MAKECOOKIE)
