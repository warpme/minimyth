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

WORKBLD = $(WORKSRC)_build

CONFIGURE_SCRIPTS = custom
BUILD_SCRIPTS     = $(WORKBLD)/Makefile
INSTALL_SCRIPTS   = $(WORKBLD)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) --target=$(GARTARGET) \
	--with-gnu-as \
	--with-gnu-ld \
	--with-local-prefix=$(patsubst %/include,%,$($(CROSSIMG)_includedir)) \
        --enable-__cxa_atexit \
	--enable-clocale=gnu \
	--enable-languages=c \
	--disable-libmudflap \
	--disable-multilib \
	--disable-nls \
	--enable-shared \
        --enable-threads=posix \
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

configure-custom:
	@mkdir -p $(WORKBLD)
	@cd $(WORKBLD) && $(CONFIGURE_ENV) ./$(call DIRSTODOTS,$(WORKBLD))/$(WORKSRC)/configure $(CONFIGURE_ARGS)
	@$(MAKECOOKIE)
