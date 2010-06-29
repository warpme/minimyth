GARNAME = vdpau-video
GARVERSION = 0.6.9
CATEGORIES = X11
MASTER_SITES = http://www.splitted-desktop.com/~gbeauchesne/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-install.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c X11/libva X11/libvdpau xorg/xorg

#CONFIGURE_SCRIPTS = $(WORKSRC)/configure
#BUILD_SCRIPTS     = $(WORKSRC)/Makefile
#INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-glx \
	--disable-debug \
	--disable-tracer \
	--disable-static \
	--enable-shared \
	--with-gnu-ld

include ../../gar.mk

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/va/vdpau_drv_video.la
	@$(MAKECOOKIE)
