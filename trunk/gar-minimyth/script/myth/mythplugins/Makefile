GARNAME = mythplugins
GARVERSION = $(MYTHTV_VERSION)
CATEGORIES = myth
MASTER_SITES  = http://www.mythtv.org/mc/
MASTER_SITES += cvs://mythtv:mythtv@cvs.mythtv.org:/var/lib/mythcvs/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME).patch.gar $(DISTNAME)-musicplaylist.patch $(DISTNAME)-init.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS  = lang/c myth/mythtv
# mythdvd
DEPENDS += lib/libdvdread
# mythgallery
DEPENDS += lib/libtiff
# mythmusic
DEPENDS += lib/libmad lib/libid3tag lib/libvorbis lib/flac lib/fftw lib/libcdaudio lib/cdparanoia X11/sdl

CONFIGURE_SCRIPTS += $(WORKSRC)/configure
CONFIGURE_SCRIPTS += $(WORKSRC)/mythtv
BUILD_SCRIPTS     += $(WORKSRC)/Makefile
INSTALL_SCRIPTS   += $(WORKSRC)/Makefile

CONFIGURE_ARGS += \
	--enable-opengl \
	--disable-mythbrowser \
	--enable-mythdvd \
		--disable-transcode \
		--enable-vcd \
	--enable-mythgallery \
		--enable-exif \
	--disable-mythgame \
	--enable-mythmusic \
		--enable-fftw \
		--enable-sdl \
		--disable-aac \
	--disable-mythnews \
	--disable-mythphone \
		--disable-festival \
	--enable-mythvideo \
	--enable-mythweather

CONFIGURE_ENV += \
	DESTDIR="$(DESTDIR)" \
	QTDIR="$(DESTDIR)$(qtprefix)" \
	OPTFLAGS="$(CFLAGS)"
BUILD_ENV     += \
	DESTDIR="$(DESTDIR)" \
	QTDIR="$(DESTDIR)$(qtprefix)" \
	OPTFLAGS="$(CFLAGS)"
INSTALL_ARGS  += \
	INSTALL_ROOT="$(DESTDIR)"

GAR_EXTRA_CONF += myth/mythtv/package-api.mk
include ../../gar.mk

cvs//%/$(DISTNAME).tar.bz2:
	@cd $(PARTIALDIR); rm -rf $(GARNAME)
	@cd $(PARTIALDIR); cvs -z3 -d:pserver:$* co -D $(GARVERSION) $(GARNAME)
	@cd $(PARTIALDIR); rm -rf $(DISTNAME)
	@cd $(PARTIALDIR); mv $(GARNAME) $(DISTNAME)
	@cd $(PARTIALDIR); tar -jc $(DISTNAME) -f $(DISTNAME).tar.bz2
	@cd $(PARTIALDIR); rm -rf $(DISTNAME)
	@$(MAKECOOKIE)

disabled-checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

configure-%/mythtv:
	@cd $* ; $(CONFIGURE_ENV) qmake $(GARNAME).pro
	@$(MAKECOOKIE)
