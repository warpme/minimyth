GARNAME = pixman
GARVERSION = 0.32.6
CATEGORIES = $(CATEGORY)
MASTER_SITES = $(XORG_MASTER_SITES)
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/COPYING

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-silent-rules \
	--enable-shared \
	--disable-static \
	--disable-openmp \
	--disable-loongson-mmi \
	--enable-mmx \
	--enable-sse2 \
	--enable-sse3 \
	--disable-vmx \
	--disable-arm-simd \
	--disable-arm-neon \
	--disable-arm-iwmmxt \
	--disable-arm-iwmmxt2 \
	--disable-mips-dspr2 \
	--enable-gcc-inline-asm \
	--disable-timers \
	--disable-gtk \
	--disable-libpng \
	--with-gnu-ld

GAR_EXTRA_CONF += $(CATEGORY)/xorg/package-api.mk
include ../../gar.mk

pre-configure:
	@$(call RUN_AUTOTOOLS)
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libpixman-1.la
	@$(MAKECOOKIE)
