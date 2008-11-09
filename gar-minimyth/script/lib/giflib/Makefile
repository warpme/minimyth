GARNAME = giflib
GARVERSION = 4.1.6
CATEGORIES = lib
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = MIT

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c xorg/xorg

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes="$(DESTDIR)$(includedir)" \
	--x-libraries="$(DESTDIR)$(libdir)" \
	--enable-shared \
	--disable-static \
	--disable-rle \
	--enable-x11 \
	--disable-gl \
	--with-gnu-ld \
	--with-x

include ../../gar.mk

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libgif.la
	@$(MAKECOOKIE)
