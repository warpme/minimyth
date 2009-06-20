GARNAME = vdpau-video
GARVERSION = 0.3.1
CATEGORIES = X11
MASTER_SITES  = http://www.splitted-desktop.com/~gbeauchesne/$(GARNAME)/
MASTER_SITES += http://www.splitted-desktop.com/~gbeauchesne/$(GARNAME)/patches/
DISTFILES = $(DISTNAME).tar.gz
LICENSE =

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c X11/libva X11/vdpau xorg/xorg

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-static \
	--enable-shared \
	--with-gnu-ld

include ../../gar.mk

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/va/nvidia_drv_video.la
	@$(MAKECOOKIE)
