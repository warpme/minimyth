GARNAME = mythplugins
GARVERSION = $(mm_MYTH_SVN_VERSION)
CATEGORIES = $(CATEGORY)
MASTER_SITES = svn://svn.mythtv.org/svn/trunk/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(GARNAME).patch.gar $(GARNAME)-init.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS  = lang/c $(CATEGORY)/mythtv
# mythdvd
DEPENDS += lib/libexif lib/libtiff
# mythmusic
DEPENDS += lib/cdparanoia lib/faad2 lib/flac lib/fftw lib/libcdaudio lib/libid3tag lib/libmad lib/libvorbis lib/SDL
# mythvideo (mtd)
DEPENDS += lib/libdvdread

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

CONFIGURE_SCRIPTS  = $(WORKSRC)/configure
CONFIGURE_SCRIPTS += $(WORKSRC)/mythtv
BUILD_SCRIPTS      = $(WORKSRC)/Makefile
INSTALL_SCRIPTS    = $(WORKSRC)/Makefile

CONFIGURE_ARGS = \
	--prefix="$(prefix)" \
	--libdir-name="lib" \
	--disable-all \
	--enable-opengl \
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

GAR_EXTRA_CONF += $(CATEGORY)/mythtv/package-api.mk
include ../../gar.mk

svn//%/$(DISTNAME).tar.bz2:
	@$(call FETCH_SVN, http://$*, $(GARVERSION), $(DISTNAME))
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

configure-%/mythtv:
	@cd $* ; $(CONFIGURE_ENV) qmake $(GARNAME).pro
	@$(MAKECOOKIE)
