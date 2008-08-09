GARNAME = libwiimote
GARVERSION = 0.4
CATEGORIES = lib
MASTER_SITES = http://ovh.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME).tgz
PATCHFILES = $(DISTNAME)-hci_remote_name.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/bluez

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST)

include ../../gar.mk

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(MAKECOOKIE)

LDFLAGS := $(LDFLAGS) `pkg-config --libs bluez`
LDFLAGS := $(LDFLAGS) -lm
