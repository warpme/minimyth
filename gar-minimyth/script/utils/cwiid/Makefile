GARNAME = cwiid
GARVERSION = 0.6.00
CATEGORIES = utils
MASTER_SITES = http://abstrakraft.org/cwiid/downloads/
DISTFILES  = $(DISTNAME).tgz
DISTFILES += gh3.config mythtv.config
PATCHFILES  = $(DISTNAME)-gtk.patch $(DISTNAME)-rootdir.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lib/bluez-libs

CONFIGURE_SCRIPTS  = $(WORKSRC)/configure
BUILD_SCRIPTS      = $(WORKSRC)/Makefile
INSTALL_SCRIPTS    = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--without-gtk \
	--without-python \
	--disable-ldconfig

include ../../gar.mk

extract-%.config:
	@cp $(DOWNLOADDIR)/$*.config $(WORKSRC)/wminput/configs/$*
	@$(MAKECOOKIE)

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(sysconfdir)/cwiid/wminput/default
	@ln -s mythtv $(DESTDIR)$(sysconfdir)/cwiid/wminput/default
	@$(MAKECOOKIE)
