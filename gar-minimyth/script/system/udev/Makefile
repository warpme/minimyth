GARNAME = udev
GARVERSION = 142
CATEGORIES = system
MASTER_SITES = ftp://ftp.kernel.org/pub/linux/utils/kernel/hotplug/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-static \
	--enable-shared \
	--with-gnu-ld \
	--with-udev-prefix=$(rootdir)

include ../../gar.mk

exec_prefix := $(rootdir)
sbindir     := $(esbindir)
libdir      := $(elibdir)

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

pre-install:
	@rm -rf $(DESTDIR)$(rootdir)/lib/udev
	@rm -rf $(DESTDIR)$(sysconfdir)/udev
	@$(MAKECOOKIE)
