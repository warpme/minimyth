GARNAME = libgcc
GARVERSION = $(GCC_VERSION)
CATEGORIES = lib
LICENSE = LGPL2_1

DESCRIPTION =
define BLURB
endef

BUILDDEPS  = lang/c
ifeq ($(DESTIMG),build)
# Make sure that the native build evironment has been built.
BUILDDEPS += \
        devel/make-bootstrap \
        devel/binutils-bootstrap \
        devel/gcc-bootstrap \
        kernel/linux-libc-headers \
        devel/glibc-headers \
        devel/glibc \
        devel/binutils-adjust-toolchain \
        devel/gcc-adjust-toolchain \
        devel/gcc \
        devel/binutils
endif
# Make sure that the basic build tools have been built.
BUILDDEPS += devel/make

BUILD_SCRIPTS   = custom
INSTALL_SCRIPTS = custom

GAR_EXTRA_CONF += devel/gcc/package-api.mk
include ../../gar.mk

build-custom:
	$(MAKE) -C $(GARDIR)/devel/gcc DESTIMG=build install
	$(MAKE) -C $(GARDIR)/devel/glibc install

install-custom:
	cp -af $(CROSS_GCC_LIBDIR)/libgcc* $(DESTDIR)$(elibdir)
	$(MAKECOOKIE)

CROSSIMG = $(DESTIMG)
export CROSSIMG
