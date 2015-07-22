GARNAME = libva
GARVERSION = $(LIBVA_VERSION)
CATEGORIES = X11
MASTER_SITES = http://cgit.freedesktop.org/libva/snapshot/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = MIT

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lang/cxx \
	xorg/libdrm \
	xorg/libX11 \
	xorg/libXext \
	xorg/libXfixes \
	xorg/Mesa

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-silent-rules \
	--disable-docs \
	--enable-drm \
	--enable-x11 \
	--enable-glx \
	--disable-egl \
	--disable-wayland \
	--disable-dummy-driver \
	--disable-static \
	--enable-shared \
	--with-drivers-path="$(libdir)/dri" \
	--with-gnu-ld

GAR_EXTRA_CONF += X11/libva/package-api.mk
include ../../gar.mk

# The snapshot is generated from git so it may have a different checksum.
checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

pre-configure:
	@mkdir -p $(WORKSRC)/m4
	@$(call RUN_AUTOTOOLS)
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libva.la
	@rm -f $(DESTDIR)$(libdir)/libva-drm.la
	@rm -f $(DESTDIR)$(libdir)/libva-glx.la
	@rm -f $(DESTDIR)$(libdir)/libva-tpi.la
	@rm -f $(DESTDIR)$(libdir)/libva-x11.la
	@$(MAKECOOKIE)
