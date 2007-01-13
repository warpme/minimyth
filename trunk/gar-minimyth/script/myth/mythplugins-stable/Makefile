GARNAME = mythplugins
GARVERSION = $(MYTHTV_STABLE_VERSION)
CATEGORIES = myth
MASTER_SITES  = http://www.mythtv.org/mc/
MASTER_SITES += svn://svn.mythtv.org/svn/trunk/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-fixes-8395.patch $(DISTNAME).patch.gar $(DISTNAME)-musicplaylist.patch $(DISTNAME)-init.patch $(DISTNAME)-video_ui.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS  = lang/c myth/mythtv-stable
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
INSTALL_ARGS  += \
	DESTDIR="$(DESTDIR)" \
	QTDIR="$(DESTDIR)$(qtprefix)" \
	QMAKESPEC="default" \
	OPTFLAGS="$(CFLAGS)" \
	INSTALL_ROOT="$(DESTDIR)"

GAR_EXTRA_CONF += myth/mythtv-stable/package-api.mk
include ../../gar.mk

svn//%/$(DISTNAME).tar.bz2:
	@cd $(PARTIALDIR); rm -rf $(GARNAME)
	@cd $(PARTIALDIR); svn co -r $(GARVERSION) http://$*
	@cd $(PARTIALDIR); rm -rf $(DISTNAME)
	@cd $(PARTIALDIR); mv $(GARNAME) $(DISTNAME)
	@cd $(PARTIALDIR); tar -jcf $(DISTNAME).tar.bz2 $(DISTNAME)
	@cd $(PARTIALDIR); rm -rf $(DISTNAME)
	@$(MAKECOOKIE)

disabled-checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

pre-configure:
	@$(if $(filter i386,  $(GARCH_FAMILY)),echo "DEFINES += HAVE_MMX" >> $(WORKSRC)/settings.pro)
	@$(if $(filter x86_64,$(GARCH_FAMILY)),echo "DEFINES -= HAVE_MMX" >> $(WORKSRC)/settings.pro)
	@$(MAKECOOKIE)

configure-%/mythtv:
	@cd $* ; $(CONFIGURE_ENV) qmake $(GARNAME).pro
	@$(MAKECOOKIE)
