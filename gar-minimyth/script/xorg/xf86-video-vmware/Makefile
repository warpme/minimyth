GARNAME = xf86-video-vmware
GARVERSION = 13.1.0
CATEGORIES = $(CATEGORY)
MASTER_SITES = $(XORG_MASTER_SITES)
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/COPYING

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c \
	$(CATEGORY)/fontsproto \
	$(CATEGORY)/libdrm \
	$(CATEGORY)/libpciaccess \
	$(CATEGORY)/randrproto \
	$(CATEGORY)/renderproto \
	$(CATEGORY)/util-macros \
	$(CATEGORY)/videoproto \
	$(CATEGORY)/xextproto \
	$(CATEGORY)/xineramaproto \
	$(CATEGORY)/xorg-server \
	$(CATEGORY)/xproto
BUILDDEPS = \
	$(CATEGORY)/xorg-sgml-doctools

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-silent-rules \
	--disable-static \
	--enable-shared \
	--with-gnu-ld

GAR_EXTRA_CONF += $(CATEGORY)/xorg/package-api.mk
include ../../gar.mk

pre-configure:
	@$(call RUN_AUTOTOOLS)
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/drivers/vmware_drv.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/drivers/vmwlegacy_drv.la
	@$(MAKECOOKIE)
