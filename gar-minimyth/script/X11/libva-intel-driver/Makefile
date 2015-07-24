GARNAME = libva-intel-driver
GARVERSION = 1.6.0
CATEGORIES = X11
MASTER_SITES = http://www.freedesktop.org/software/vaapi/releases/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = MIT

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lang/cxx X11/libva xorg/xorg

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-silent-rules \
	--enable-drm \
	--enable-x11 \
	--disable-wayland \
	--disable-static \
	--enable-shared \
	--with-gnu-ld

include ../../gar.mk

pre-configure:
	@$(call RUN_AUTOTOOLS)
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/dri/i965_drv_video.la
	@$(MAKECOOKIE)
