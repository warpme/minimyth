GARNAME = mythplugins
GARVERSION = 0.20a
CATEGORIES = myth
MASTER_SITES = http://www.mythtv.org/mc/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-fixes-$(MYTHTV_STABLE20_FIXES_VERSION).patch $(DISTNAME).patch.gar $(DISTNAME)-init.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS  = lang/c myth/mythtv-stable20p30
# mythdvd
DEPENDS += lib/libdvdread
# mythgallery
DEPENDS += lib/libexif lib/libtiff
# mythmusic
DEPENDS += lib/cdparanoia lib/faad2 lib/flac lib/fftw lib/libcdaudio lib/libid3tag lib/libmad lib/libvorbis lib/SDL

CONFIGURE_SCRIPTS  = $(WORKSRC)/configure
CONFIGURE_SCRIPTS += $(WORKSRC)/mythtv
BUILD_SCRIPTS      = $(WORKSRC)/Makefile
INSTALL_SCRIPTS    = $(WORKSRC)/Makefile

CONFIGURE_ARGS = \
	--prefix="$(prefix)" \
	--libdir-name="lib" \
	--disable-all \
	--enable-opengl \
	--enable-mythdvd \
	--enable-mythgallery \
		--enable-exif \
		--enable-new-exif \
	--enable-mythgame \
	--enable-mythmusic \
		--enable-fftw \
		--enable-sdl \
		--enable-aac \
	--enable-mythnews \
	--enable-mythvideo \
	--enable-mythweather

CONFIGURE_ENV = \
	DESTDIR="$(DESTDIR)" \
	QTDIR="$(DESTDIR)$(qtprefix)" \
	QMAKESPEC="default" \
	OPTFLAGS="$(CFLAGS)"
BUILD_ENV     = \
	DESTDIR="$(DESTDIR)" \
	QTDIR="$(DESTDIR)$(qtprefix)" \
	QMAKESPEC="default" \
	OPTFLAGS="$(CFLAGS)"
INSTALL_ENV   = \
	DESTDIR="$(DESTDIR)" \
	QTDIR="$(DESTDIR)$(qtprefix)" \
	QMAKESPEC="default" \
	OPTFLAGS="$(CFLAGS)" \
	INSTALL_ROOT="$(DESTDIR)"

GAR_EXTRA_CONF += myth/mythtv-stable20p30/package-api.mk
include ../../gar.mk

configure-%/mythtv:
	@cd $* ; $(CONFIGURE_ENV) qmake $(GARNAME).pro
	@$(MAKECOOKIE)

post-install:
	@install -d $(DESTDIR)$(versiondir) 
	@echo "$(GARVERSION) with fixes through SVN $(MYTHTV_STABLE20_FIXES_VERSION)" > $(DESTDIR)$(versiondir)/$(GARNAME)
	@$(MAKECOOKIE)
