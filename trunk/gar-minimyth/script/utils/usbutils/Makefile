GARNAME = usbutils
GARVERSION = 0.81
CATEGORIES = utils
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/linux-usb/
DISTFILES = $(DISTNAME).tar.gz usb.ids
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/libusb lib/zlib

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST)

include ../../gar.mk

extract-usb.ids:
	@cp -f $(DOWNLOADDIR)/usb.ids $(WORKSRC)/usb.ids
	@$(MAKECOOKIE)
