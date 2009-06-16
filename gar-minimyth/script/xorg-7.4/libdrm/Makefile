GARNAME = libdrm
GARVERSION = 2.4.11
CATEGORIES = $(CATEGORY)
MASTER_SITES = http://dri.freedesktop.org/libdrm/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = MIT

DESCRIPTION = 
define BLURB
endef

DEPENDS  = lang/c \
	$(CATEGORY)/libpthread-stubs
ifneq ($(DESTIMG),build)
DEPENDS += system/udev
endif

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS  = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-static \
	--enable-shared \
	--disable-nouveau-experimental-api \
	--with-gnu-ld
ifeq ($(DESTIMG),build)
CONFIGURE_ARGS += \
	--disable-udev
else
CONFIGURE_ARGS += \
	--enable-udev
endif

include ../../gar.mk

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/$(GARNAME).la
	@rm -f $(DESTDIR)$(libdir)/$(GARNAME)_intel.la
	@$(MAKECOOKIE)
