GARNAME = usbutils
GARVERSION = 0.73
CATEGORIES = utils
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/linux-usb/
DISTFILES = $(DISTNAME).tar.gz config.cache.$(GARCH_FAMILY) usb.ids
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/libusb lib/zlib

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--cache-file=config.cache

include ../../gar.mk

extract-config.cache.$(GARCH_FAMILY):
	@cp $(DOWNLOADDIR)/config.cache.$(GARCH_FAMILY) $(WORKSRC)/config.cache
	@$(MAKECOOKIE)

extract-usb.ids:
	@cp -f $(DOWNLOADDIR)/usb.ids $(WORKSRC)/usb.ids
	@$(MAKECOOKIE)
