GARNAME = xf86-input-mouse
GARVERSION = 1.0.3.1
CATEGORIES = xorg-new
MASTER_SITES = http://xorg.freedesktop.org/releases/X11R$(XORG_VERSION)/src/driver/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/COPYING

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c xorg-new/xorg-server xorg-new/xproto

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--cache-file=config.cache \
	--with-gnu-ld

GAR_EXTRA_CONF += xorg-new/xorg/package-api.mk
include ../../gar.mk

pre-configure:
	@rm -f $(WORKSRC)/config.cache
	@echo "`echo ac_cv_file_$(prefix)/share/X11/sgml/defs.ent | sed -e 's%[^a-zA-Z0-9]%_%g'`=no" >> $(WORKSRC)/config.cache
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/input/mouse_drv.la
	@$(MAKECOOKIE)
