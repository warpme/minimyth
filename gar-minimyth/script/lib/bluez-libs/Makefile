GARNAME = bluez-libs
GARVERSION = 3.30
CATEGORIES = lib
MASTER_SITES = http://bluez.sf.net/download/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--with-gnu-ld

include ../../gar.mk

post-install:
	@rm -f $(DESTDIR)$(libdir)/libbluetooth.la
	@$(MAKECOOKIE)
