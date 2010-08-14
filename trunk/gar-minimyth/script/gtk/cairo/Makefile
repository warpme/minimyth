GARNAME = cairo
GARVERSION = 1.8.10
CATEGORIES = gtk
MASTER_SITES = http://www.cairographics.org/releases/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = LGPL2_1

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/fontconfig lib/freetype lib/libpng xorg/xorg

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes="$(DESTDIR)$(includedir)" \
	--x-libraries="$(DESTDIR)$(libdir)" \
	--enable-shared \
	--disable-static \
	--disable-gtk-doc \
	--disable-gcov \
	--enable-xlib \
	--enable-xlib-xrender \
	--enable-xcb \
	--disable-quartz \
	--disable-quartz-font \
	--disable-quartz-image \
	--disable-win32 \
	--disable-win32-font \
	--disable-os2 \
	--disable-beos \
	--enable-png \
	--disable-glitz \
	--disable-directfb \
	--enable-ft \
	--enable-pthread \
	--enable-ps \
	--enable-pdf \
	--enable-svg \
	--disable-test-surfaces \
	--enable-some-floating-point \
	--with-gnu-ld \
	--with-x

CONFIGURE_ENV = \
	png_REQUIRES="libpng"

include ../../gar.mk

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(call FIX_LIBTOOL,$(WORKSRC),configure)
	@$(MAKECOOKIE)

post-install:
	@rm -rf $(DESTDIR)$(libdir)/libcairo.la
	@$(MAKECOOKIE)
