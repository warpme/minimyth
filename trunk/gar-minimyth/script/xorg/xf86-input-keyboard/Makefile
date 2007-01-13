GARNAME = xf86-input-keyboard
GARVERSION = 1.0.1.3
CATEGORIES = xorg
MASTER_SITES = http://xorg.freedesktop.org/releases/X11R$(XORG_VERSION)/src/driver/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE =

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c xorg/xorg-server xorg/xproto

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-depkbd \
	--with-gnu-ld

GAR_EXTRA_CONF += xorg/xorg/package-api.mk
include ../../gar.mk
include ../xorg.mk

post-install:
	@rm -f $(DESTDIR)$(x11libdir)/xorg/modules/input/kbd_drv.la
	@rm -f $(DESTDIR)$(x11libdir)/xorg/modules/input/keyboard_drv.la
	@$(MAKECOOKIE)
