GARNAME = mythtv
GARVERSION = $(MYTHTV_VERSION)
CATEGORIES = myth
MASTER_SITES = cvs://mythtv:mythtv@cvs.mythtv.org:/var/lib/mythcvs/
CONFIGFILE = settings.pro
DISTFILES = $(GARNAME)-$(GARVERSION).tar.bz2 $(CONFIGFILE)
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lang/c++ lib/lame lib/alsa-lib db/mysql X11/freetype X11/X11 qt/qt lirc/lirc

CONFIGURE_SCRIPTS = $(WORKSRC)/configure custom
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

# There is at least one problem with cross compiling libavcodecs.
CONFIGURE_ARGS = $(DIRPATHS) \
	--cpu=$(GARCH) \
	--extra-cflags="$(CFLAGS)" \
	--extra-ldflags="$(LDFLAGS)"
CONFIGURE_ENV  = \
	DESTDIR="$(DESTDIR)" \
	QTDIR="$(DESTDIR)$(qtprefix)" \
	OPTFLAGS="$(CFLAGS)" \
	PREFIX="$(prefix)"
BUILD_ARGS     = \
	PREFIX="$(prefix)"
BUILD_ENV      = \
	DESTDIR="$(DESTDIR)" \
	QTDIR="$(DESTDIR)$(qtprefix)" \
	OPTFLAGS="$(CFLAGS)"
INSTALL_ARGS   = \
	INSTALL_ROOT="$(DESTDIR)"

GAR_EXTRA_CONF += myth/mythtv/package-api.mk
include ../../gar.mk

cvs//%/$(GARNAME)-$(GARVERSION).tar.bz2:
	@cd $(PARTIALDIR); rm -rf $(GARNAME)
	@cd $(PARTIALDIR); cvs -z3 -d:pserver:$* co -D $(GARVERSION) $(GARNAME)
	@cd $(PARTIALDIR); rm -rf $(GARNAME)-$(GARVERSION)
	@cd $(PARTIALDIR); mv $(GARNAME) $(GARNAME)-$(GARVERSION)
	@cd $(PARTIALDIR); tar -jc $(GARNAME)-$(GARVERSION) -f $(GARNAME)-$(GARVERSION).tar.bz2
	@cd $(PARTIALDIR); rm -rf $(GARNAME)-$(GARVERSION)
	@$(MAKECOOKIE)

checksum-$(GARNAME)-$(GARVERSION).tar.bz2:
	@$(MAKECOOKIE)

extract-$(CONFIGFILE):
	@cp $(DOWNLOADDIR)/$(CONFIGFILE) $(WORKSRC)/settings.pro
	@sed -i 's%@PREFIX@%$(prefix)%' $(WORKSRC)/settings.pro
	@$(MAKECOOKIE)

post-extract:
# There are serveral references that assume we are not cross compiling or relocating the installation.
	@sed -i 's%`freetype-config%`$(DESTDIR)$(bindir)/freetype-config%g' $(WORKSRC)/configure
	@sed -i 's%`freetype-config%`$(DESTDIR)$(bindir)/freetype-config%g' $(WORKSRC)/libs/libmythtv/libmythtv.pro
	@sed -i 's%`sdl-config%`$(DESTDIR)$(bindir)/sdl-config%g' $(WORKSRC)/configure
	@sed -i 's%`xml2-config%`$(DESTDIR)$(bindir)/xml2-config%g' $(WORKSRC)/contrib/mythnotify/mythudprelay/Makefile
	@sed -i 's% -L/usr/X11R6/lib% -L$$(QMAKE_LIBDIR_X11)%g' $(WORKSRC)/contrib/mythnotify/cidbcast/Makefile
	@sed -i 's% -L/usr/X11R6/lib% -L$$(QMAKE_LIBDIR_X11)%g' $(WORKSRC)/contrib/mythnotify/mythudprelay/Makefile
	@sed -i 's% -L/usr/X11R6/lib% -L$$$$(QMAKE_LIBDIR_X11)%g' $(WORKSRC)/libs/libmyth/libmyth.pro
	@sed -i 's% -L/usr/X11R6/lib% -L$$$$(QMAKE_LIBDIR_X11)%g' $(WORKSRC)/libs/libmythui/libmythui.pro
# Since fadeway causes the audio to stutter on the Via EIPA ME6000, we disable fadeaway.
	@sed -i 's%[ \t]*<fadeaway>.*</fadeaway>[ \t]*%%g' $(WORKSRC)/themes/blueosd/osd.xml
	@sed -i 's%[ \t]*<fadeaway>.*</fadeaway>[ \t]*%%g' $(WORKSRC)/themes/defaultosd/osd.xml
	@sed -i 's%[ \t]*<fadeaway>.*</fadeaway>[ \t]*%%g' $(WORKSRC)/themes/Titivillus-OSD/osd.xml
	@$(MAKECOOKIE)

configure-custom: 
	@cd $(WORKSRC) ; $(CONFIGURE_ENV) qmake $(GARNAME).pro
	@$(MAKECOOKIE)
