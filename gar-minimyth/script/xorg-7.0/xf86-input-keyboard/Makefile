GARNAME = xf86-input-keyboard
GARVERSION = X11R$(XORG_VERSION)-1.0.1.3
CATEGORIES = xorg-7.0
MASTER_SITES = http://xorg.freedesktop.org/releases/X11R$(XORG_VERSION)/src/driver/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/COPYING

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c xorg-7.0/xorg-server xorg-7.0/xproto

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-depkbd \
	--with-gnu-ld

GAR_EXTRA_CONF += xorg-7.0/xorg/package-api.mk
include ../../gar.mk

CFLAGS   := $(patsubst -O%,,$(CFLAGS)  ) -O2
CXXFLAGS := $(patsubst -O%,,$(CXXFLAGS)) -O2

post-install:
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/input/kbd_drv.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/input/keyboard_drv.la
	@$(MAKECOOKIE)
