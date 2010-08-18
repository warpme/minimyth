GARNAME = libva
GARVERSION = 0.31.1
CATEGORIES = X11
MASTER_SITES = http://www.splitted-desktop.com/~gbeauchesne/$(GARNAME)/
DISTFILES = $(GARNAME)_$(GARVERSION)-1+sds4.tar.gz
LICENSE = MIT

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c xorg/xorg

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-glx \
	--disable-dummy-driver \
	--disable-dummy-backend \
	--enable-i965-driver \
	--disable-static \
	--enable-shared \
	--with-drivers-path="$(libdir)/va" \
	--with-gnu-ld

include ../../gar.mk

pre-patch:
	cd $(WORKSRC) ; cat debian/patches/*.patch | patch -p1
	$(MAKECOOKIE)

pre-configure:
	@$(call RUN_AUTOTOOLS)
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libva.la
	@rm -f $(DESTDIR)$(libdir)/libva-compat.la
	@rm -f $(DESTDIR)$(libdir)/libva-glx.la
	@rm -f $(DESTDIR)$(libdir)/libva-tpi.la
	@rm -f $(DESTDIR)$(libdir)/libva-x11.la
	@rm -f $(DESTDIR)$(libdir)/va/i965_drv_video.la
	@$(MAKECOOKIE)
