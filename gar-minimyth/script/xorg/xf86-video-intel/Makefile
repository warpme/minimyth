GARNAME = xf86-video-intel
GARVERSION = 2.99.917
CATEGORIES = $(CATEGORY)
MASTER_SITES = $(XORG_MASTER_SITES)
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = \
	$(DISTNAME)-xorg_server_h.patch \
	$(DISTNAME)-pkg_config.patch
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/COPYING

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c system/udev \
	$(CATEGORY)/dri2proto \
	$(CATEGORY)/fontsproto \
	$(CATEGORY)/libdrm \
	$(CATEGORY)/libpciaccess \
	$(CATEGORY)/libX11 \
	$(CATEGORY)/libXext \
	$(CATEGORY)/libXfixes \
	$(CATEGORY)/libXrender \
	$(CATEGORY)/libXvMC \
	$(CATEGORY)/pixman \
	$(CATEGORY)/randrproto \
	$(CATEGORY)/renderproto \
	$(CATEGORY)/util-macros \
	$(CATEGORY)/xcb-util \
	$(CATEGORY)/xextproto \
	$(CATEGORY)/xf86driproto \
	$(CATEGORY)/xorg-server \
	$(CATEGORY)/xproto

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-silent-rules \
	--disable-static \
	--enable-shared \
	--enable-udev \
	--enable-dri \
	--enable-dri2 \
	--disable-dri3 \
	--enable-xvmc \
	--enable-kms \
	--enable-ums \
	--disable-kms-only \
	--disable-ums-only \
	--enable-sna \
	--enable-uxa \
	--disable-xaa \
	--disable-dga \
	--disable-tear-free \
	--disable-rendernode \
	--disable-wc-mmap \
	--disable-create2 \
	--disable-async-swap \
	--disable-debug \
	--disable-valgrind \
	--with-gnu-ld

GAR_EXTRA_CONF += $(CATEGORY)/xorg/package-api.mk
include ../../gar.mk

# xf86-video-intel 2.99.917 fails to compile with gcc 5.2.0's link time optimization enabled.
CFLAGS   := $(filter-out -flto, $(CFLAGS))   -fno-lto
CXXFLAGS := $(filter-out -flto, $(CXXFLAGS)) -fno-lto
LDFLAGS  := $(filter-out -flto, $(LDFLAGS))  -fno-lto

pre-configure:
	@$(call RUN_AUTOTOOLS)
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libI810XvMC.la
	@rm -f $(DESTDIR)$(libdir)/libIntelXvMC.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/drivers/intel_drv.la
	@$(MAKECOOKIE)
