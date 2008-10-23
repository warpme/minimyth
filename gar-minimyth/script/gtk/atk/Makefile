GARNAME = atk
GARVERSION = 1.24.0
CATEGORIES = lib
MASTER_SITES = http://ftp.gnome.org/pub/GNOME/sources/atk/1.24/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = LGPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/glib

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-rebuilds \
	--disable-glibtest \
	--disable-gtk-doc \
	--with-gnu-ld

include ../../gar.mk

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC),configure)
	@$(MAKECOOKIE)

post-install:
	@rm -rf $(DESTDIR)$(libdir)/libatk-1.0.la
	@$(MAKECOOKIE)
