GARNAME = libgcc
GARVERSION = $(GCC_VERSION)
CATEGORIES = lib
LICENSE = LGPL2_1

DESCRIPTION =
define BLURB
endef

BUILDDEPS = \
	lang/c \
	devel/make \
	devel/binutils \
	devel/gcc \
	devel/bison \
	devel/flex \
	devel/gettext \
	devel/autoconf \
	devel/automake \
	devel/libtool

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
