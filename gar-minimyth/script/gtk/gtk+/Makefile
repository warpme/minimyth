GARNAME = gtk+
GARVERSION = 2.14.4
CATEGORIES = lib
MASTER_SITES = http://ftp.gnome.org/pub/GNOME/sources/gtk+/2.14/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-disable_demos.patch
LICENSE = LGPL2

DESCRIPTION =
define BLURB
endef

DEPENDS    = lang/c gtk/atk gtk/cairo gtk/pango lib/glib lib/libjpeg lib/libpng lib/libtiff xorg/xorg
BUILDDEPS  =
ifneq ($(DESTIMG),build)
BUILDDEPS += gtk/gtk+
endif

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes="$(DESTDIR)$(includedir)" \
	--x-libraries="$(DESTDIR)$(libdir)" \
	--enable-shm \
	--disable-xkb \
	--enable-xinerama \
	--enable-rebuilds \
	--enable-visibility \
	--enable-explicit-deps=auto \
	--disable-glibtest \
	--enable-modules \
	--disable-gdiplus \
	--disable-cups \
	--disable-test-print-backend \
	--disable-gtk-doc \
	--disable-man \
	--with-gnu-ld \
	--with-libpng \
	--with-libjpeg \
	--with-libtiff \
	--without-libjasper \
	--with-x

CONFIGURE_ENV  =
ifneq ($(DESTIMG),build)
CONFIGURE_ENV += \
	gio_can_sniff='yes'
endif

include ../../gar.mk

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC),configure)
	@$(MAKECOOKIE)

post-install:
	@rm -rf $(DESTDIR)$(libdir)/gtk-2.0/modules/*.la
	@rm -rf $(DESTDIR)$(libdir)/gtk-2.0/2.10.0/engines/*.la
	@rm -rf $(DESTDIR)$(libdir)/gtk-2.0/2.10.0/immodules/*.la
	@rm -rf $(DESTDIR)$(libdir)/gtk-2.0/2.10.0/loaders/*.la
	@rm -rf $(DESTDIR)$(libdir)/gtk-2.0/2.10.0/printbackends/*.la
	@rm -rf $(DESTDIR)$(libdir)/libgailutil.la
	@rm -rf $(DESTDIR)$(libdir)/libgdk_pixbuf-2.0.la
	@rm -rf $(DESTDIR)$(libdir)/libgdk_pixbuf_xlib-2.0.la
	@rm -rf $(DESTDIR)$(libdir)/libgdk-x11-2.0.la
	@rm -rf $(DESTDIR)$(libdir)/libgtk-x11-2.0.la
	@$(MAKECOOKIE)
