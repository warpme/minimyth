GARNAME = mythplugins
GARVERSION = 0.18.1
CATEGORIES = myth
MASTER_SITES = http://www.mythtv.org/mc/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-fixes-$(MYTHTV_STABLE18_FIXES_VERSION).patch $(DISTNAME).patch.gar $(DISTNAME)-musicplaylist.patch $(DISTNAME)-init.patch $(DISTNAME)-video_ui.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS  = lang/c myth/mythtv-stable18
# mythdvd
DEPENDS += lib/libdvdread
# mythgallery
DEPENDS += lib/libexif lib/libtiff
# mythmusic
DEPENDS += lib/cdparanoia lib/faad2 lib/flac lib/fftw lib/libcdaudio lib/libid3tag lib/libmad lib/libvorbis lib/SDL

CONFIGURE_SCRIPTS += $(WORKSRC)/configure
CONFIGURE_SCRIPTS += $(WORKSRC)/mythtv
BUILD_SCRIPTS     += $(WORKSRC)/Makefile
INSTALL_SCRIPTS   += $(WORKSRC)/Makefile

CONFIGURE_ARGS += \
	--disable-all \
	--enable-opengl \
	--enable-mythdvd \
		--enable-transcode \
		--enable-vcd \
	--enable-mythgallery \
		--enable-exif \
	--enable-mythmusic \
		--enable-fftw \
		--enable-sdl \
		--enable-aac \
	--enable-mythnews \
	--enable-mythvideo \
	--enable-mythweather

CONFIGURE_ENV += \
	DESTDIR="$(DESTDIR)" \
	QTDIR="$(DESTDIR)$(qtprefix)" \
	QMAKESPEC="default" \
	OPTFLAGS="$(CFLAGS)"
BUILD_ENV     += \
	DESTDIR="$(DESTDIR)" \
	QTDIR="$(DESTDIR)$(qtprefix)" \
	QMAKESPEC="default" \
	OPTFLAGS="$(CFLAGS)"
INSTALL_ENV   += \
	DESTDIR="$(DESTDIR)" \
	QTDIR="$(DESTDIR)$(qtprefix)" \
	QMAKESPEC="default" \
	OPTFLAGS="$(CFLAGS)" \
	INSTALL_ROOT="$(DESTDIR)"

GAR_EXTRA_CONF += myth/mythtv-stable18/package-api.mk
include ../../gar.mk

pre-configure:
	@$(if $(filter i386,  $(GARCH_FAMILY)),echo "DEFINES += HAVE_MMX" >> $(WORKSRC)/settings.pro)
	@$(if $(filter x86_64,$(GARCH_FAMILY)),echo "DEFINES -= HAVE_MMX" >> $(WORKSRC)/settings.pro)
	@$(MAKECOOKIE)

configure-%/mythtv:
	@cd $* ; $(CONFIGURE_ENV) qmake $(GARNAME).pro
	@$(MAKECOOKIE)
