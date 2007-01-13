GARNAME = lirc
GARVERSION = $(LIRC_VERSION)
CATEGORIES = lirc
MASTER_SITES  = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
MASTER_SITES += http://lirc.sourceforge.net/software/snapshots/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-libusb.patch $(DISTNAME)-any.patch $(DISTNAME)-fixes.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS  = $(LIRC_DEPENDS)
DEPENDS += $(addprefix lirc/,$(filter lirc.%,$(shell cd ../ ; ls )))

WORKSRC = $(LIRC_WORKSRC)

CONFIGURE_SCRIPTS = $(LIRC_CONFIGURE_SCRIPTS)
BUILD_SCRIPTS     = $(LIRC_BUILD_SCRIPTS)
INSTALL_SCRIPTS   = $(LIRC_INSTALL_SCRIPTS)

CONFIGURE_ARGS = $(LIRC_CONFIGURE_ARGS) --with-driver=none
BUILD_ARGS     = $(LIRC_BUILD_ARGS)
INSTALL_ARGS   = $(LIRC_INSTALL_ARGS)

CONFIGURE_ENV = $(LIRC_CONFIGURE_ENV)
BUILD_ENV     = $(LIRC_BUILD_ENV)
INSTALL_ENV   = $(LIRC_INSTALL_ENV)

GAR_EXTRA_CONF += lirc/lirc/package-api.mk
include ../../gar.mk

post-install:
	@rm -f $(DESTDIR)$(libdir)/liblirc_client.la
	@depmod -b $(DESTDIR) -v $(KERNEL_FULL_VERSION)
	@$(MAKECOOKIE)
