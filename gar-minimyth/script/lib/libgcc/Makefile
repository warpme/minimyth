GARNAME = libgcc
GARVERSION = $(GCC_VERSION)
CATEGORIES = lib
LICENSE = LGPL2_1

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

BUILD_SCRIPTS   = custom
INSTALL_SCRIPTS = custom

GAR_EXTRA_CONF += devel/gcc/package-api.mk
include ../../gar.mk

build-custom:
	@$(MAKE) -C $(GARDIR)/devel/gcc DESTIMG=build install
	@$(MAKECOOKIE)

install-custom:
	@cp -af $(CROSS_GCC_LIBDIR)/libgcc* $(DESTDIR)$(elibdir)
	@$(MAKECOOKIE)

CROSSIMG = $(DESTIMG)
export CROSSIMG
