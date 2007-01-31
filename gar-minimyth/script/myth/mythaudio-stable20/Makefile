GARNAME = mythaudio
GARVERSION = \
	$(strip $(if $(MYTHAUDIO_DEVEL_VERSION), \
		$(MYTHAUDIO_DEVEL_VERSION), \
		0.0.0 \
	))
CATEGORIES = myth
MASTER_SITES = \
	$(strip $(if $(MYTHAUDIO_DEVEL_PATH), \
		dir:/$(MYTHAUDIO_DEVEL_PATH) \
	))
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS  = lang/c myth/mythtv-stable20
DEPENDS += lib/cdparanoia lib/faad2 lib/flac lib/fftw lib/libcdaudio lib/libid3tag lib/libmad lib/libvorbis lib/SDL

CONFIGURE_SCRIPTS  = $(WORKSRC)/configure
CONFIGURE_SCRIPTS += $(WORKSRC)/mythtv
BUILD_SCRIPTS      = $(WORKSRC)/Makefile
INSTALL_SCRIPTS    = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST)

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
INSTALL_ARGS  = \
	DESTDIR="$(DESTDIR)" \
	QTDIR="$(DESTDIR)$(qtprefix)" \
	QMAKESPEC="default" \
	OPTFLAGS="$(CFLAGS)" \
	INSTALL_ROOT="$(DESTDIR)"

include ../../gar.mk

# $(call FETCH_DIR, <dirname>, <basename>, <version>, <file_base>)
FETCH_DIR = \
	mkdir -p $(PARTIALDIR)                                          ; \
	cd $(PARTIALDIR)                                                ; \
	rm -rf $(strip $(4))                                            ; \
	rm -rf $(strip $(4)).tar.bz2                                    ; \
	cp -rfp $(strip $(1))/$(strip $(2)) $(strip $(4))               ; \
	if [ ! -d $(strip $(4)) ] ; then                                  \
		rm -rf $(strip $(4))                                    ; \
		rm -rf $(strip $(4)).tar.bz2                            ; \
		exit 1                                                  ; \
	fi                                                              ; \
	tar --exclude '*/.svn' -jcf $(strip $(4)).tar.bz2 $(strip $(4)) ; \
	rm -rf $(strip $(4))

dir/%/$(DISTNAME).tar.bz2:
	@$(call FETCH_DIR, $*, $(GARNAME), $(GARVERSION), $(DISTNAME))
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(MAKECOOKIE)

configure-%/mythtv:
	@cd $* ; $(CONFIGURE_ENV) qmake $(GARNAME).pro
	@$(MAKECOOKIE)
