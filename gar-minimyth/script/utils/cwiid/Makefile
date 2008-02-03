GARNAME = cwiid
GARVERSION = 0.6.00
CATEGORIES = utils
MASTER_SITES = http://abstrakraft.org/cwiid/downloads/
DISTFILES = $(DISTNAME).tgz
PATCHFILES = $(DISTNAME)-gtk.patch $(DISTNAME)-rootdir.patch $(DISTNAME)-ioctl_ui_set_phys.patch
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

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(MAKECOOKIE)
