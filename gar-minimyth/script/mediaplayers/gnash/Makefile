GARNAME = gnash
GARVERSION = 0.8.4
CATEGORIES = mediaplayers
MASTER_SITES = ftp://ftp.gnu.org/gnu/$(GARNAME)/$(GARVERSION)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-cross.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c++ lib/agg lib/boost lib/expat lib/ffmpeg lib/fontconfig lib/freetype lib/giflib lib/glib lib/libjpeg lib/libpng lib/SDL lib/zlib net/curl system/lirc xorg/xorg

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-nls \
	--disable-rpath \
	--disable-jemalloc \
	--disable-debugger \
	--disable-fps-debug \
	--disable-allstatic \
	--disable-menus \
	--disable-swftree \
	--disable-testsuite \
	--disable-write \
	--disable-cygnal \
	--disable-i810-lod-bias \
	--enable-gui=sdl \
	--enable-renderer=agg \
	--enable-mit-shm \
	--enable-media=ffmpeg \
	--enable-lirc \
	--disable-static \
	--enable-shared \
	--disable-atk \
	--disable-glext \
	--disable-cairo \
	--disable-kparts \
	--enable-npapi \
	--enable-plugins \
	--disable-xpcom \
	--disable-nspr \
	--enable-z \
	--enable-jpeg \
	--enable-libpng \
	--enable-gif \
	--disable-ungif \
	--enable-fontconfig \
	--disable-ghelp \
	--enable-Xft \
	--enable-expat \
	--disable-gstreamer \
	--enable-glib \
	--disable-fltk2 \
	--disable-docbook \
	--enable-visibility \
	--disable-strict \
	--enable-cassert \
	--with-gnu-ld \
	--with-plugins-install=system \
	--with-npapi-install=system \
	--with-npapi-plugindir="$(libdir)/mozilla/plugins" \
	--with-z-incl="$(DESTDIR)$(includedir)" \
	--with-z-lib="$(DESTDIR)$(libdir)" \
	--with-jpeg-incl="$(DESTDIR)$(includedir)" \
	--with-jpeg-lib="$(DESTDIR)$(libdir)" \
	--with-boost-incl="$(DESTDIR)$(includedir)" \
	--with-boost-lib="$(DESTDIR)$(libdir)"

INSTALL_ARGS = \
	install-plugin

CONFIGURE_ENV =  \
	SDL_CONFIG="$(DESTDIR)$(bindir)/sdl-config"

include ../../gar.mk

pre-configure:
	@rm -f $(WORKSRC)/macros/libltdl.m4
	@rm -f $(WORKSRC)/macros/pkg.m4
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)/$(libdir)/gnash/libgnashamf.la
	@rm -f $(DESTDIR)/$(libdir)/gnash/libgnashbase.la
	@rm -f $(DESTDIR)/$(libdir)/gnash/libgnashcore.la
	@rm -f $(DESTDIR)/$(libdir)/gnash/libgnashmedia.la
	@rm -f $(DESTDIR)/$(libdir)/gnash/libgnashnet.la
	@rm -f $(DESTDIR)/$(libdir)/gnash/libmozsdk.la
	@$(MAKECOOKIE)
