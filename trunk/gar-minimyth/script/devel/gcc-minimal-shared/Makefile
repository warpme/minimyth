GARNAME = gcc-minimal-shared
GARVERSION = $(GCC_VERSION)
CATEGORIES = devel
SOURCEPKG = devel/gcc
LICENSE = GPL2/LGPL2_1

DESCRIPTION = 
define BLURB
endef

CROSSIMG ?= $(DESTIMG)
GARTARGET = $($(CROSSIMG)_GARHOST)

IMGDEPS += $(CROSSIMG)
$(CROSSIMG)_DEPENDS = kernel/linux-libc-headers devel/glibc-crtobjs
DEPENDS = lang/c devel/binutils

WORKDIR   = $(WORKROOTDIR)/$(DESTIMG)_$(CROSSIMG).d
COOKIEDIR = $(COOKIEROOTDIR)/$(DESTIMG)_$(CROSSIMG).d

WORKSRC = $(WORKDIR)/gcc-$(GARVERSION)

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) --target=$(GARTARGET) \
	--with-local-prefix=$(patsubst %/include,%,$($(CROSSIMG)_includedir)) \
	--enable-languages=c \
	--disable-nls \
	--enable-shared \
	--enable-multilib=no \
        --enable-version-specific-runtime-libs
ifneq ($(DESTIMG),$(CROSSIMG))
CONFIGURE_ARGS += \
	--with-sysroot=$($(CROSSIMG)_DESTDIR)
endif

GAR_EXTRA_CONF += devel/gcc/package-api.mk

include ../../gar.mk

# Do not link to libc.so, because it is not available yet.
pre-configure:
	@sed -i '/^SHLIB_LC = /s%-lc%%' $(WORKSRC)/gcc/config/t-slibgcc-elf-ver
	@$(MAKECOOKIE)
