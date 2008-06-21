GARNAME = xosd
GARVERSION = 2.2.14
CATEGORIES = X11
MASTER_SITES = http://ignavus.net/
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/libxosd/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-defaults.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c xorg/xorg

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes=$(DESTDIR)$(includedir) \
	--x-libraries=$(DESTDIR)$(libdir) \
	--disable-gtktest \
	--enable-xinerama \
	--disable-gdk_pixbuftest \
	--disable-new-plugin \
	--disable-beep_media_player_plugin \
	--disable-old-plugin \
	--with-gnu-ld \
	--with-x

CONFIGURE_ENV = \
	GTK_CONFIG="no"

include ../../gar.mk

post-install:
	@rm -f $(DESTDIR)$(libdir)/libxosd.la
	@$(MAKECOOKIE)
	
