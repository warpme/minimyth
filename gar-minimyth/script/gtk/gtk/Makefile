GARNAME = gtk+
GARVERSION = 2.20.1
CATEGORIES = gtk
MASTER_SITES = http://ftp.gnome.org/pub/GNOME/sources/gtk+/2.20/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-nm.patch
LICENSE = LGPL2

DESCRIPTION =
define BLURB
endef

DEPENDS    = lang/c lang/cxx gtk/atk gtk/cairo gtk/glib gtk/pango lib/libjpeg lib/libpng lib/libtiff xorg/xorg
BUILDDEPS  = gtk/gtk-doc
ifneq ($(DESTIMG),build)
BUILDDEPS += gtk/gtk
endif

CONFIGURE_SCRIPTS  = $(WORKSRC)/configure
BUILD_SCRIPTS      = $(WORKSRC)/Makefile
INSTALL_SCRIPTS    = $(WORKSRC)/Makefile
ifeq ($(DESTIMG),build)
INSTALL_SCRIPTS   += gdk-pixbuf.loaders
endif

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes="$(DESTDIR)$(includedir)" \
	--x-libraries="$(DESTDIR)$(libdir)" \
	--disable-silent-rules \
	--disable-static \
	--enable-shared \
	--enable-debug=minimal \
	--enable-shm \
	--enable-xkb \
	--enable-xinerama \
	--enable-rebuilds \
	--enable-visibility \
	--enable-explicit-deps=auto \
	--disable-glibtest \
	--enable-modules \
	--disable-gdiplus \
	--disable-cups \
	--disable-papi \
	--disable-test-print-backend \
	--disable-introspection \
	--disable-gtk-doc \
	--disable-man \
	--with-gnu-ld \
	--without-xinput \
	--with-gtkgarget=x11 \
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

# Fails to compile using GCC's linker plugin due to segmentation fault.
CFLAGS   := $(filter-out -fuse-linker-plugin, $(CFLAGS))
CXXFLAGS := $(filter-out -fuse-linker-plugin, $(CXXFLAGS))
LDFLAGS  := $(filter-out -fuse-linker-plugin, $(LDFLAGS))

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install
	@$(call FIX_LIBTOOL,$(WORKSRC),configure)
	@$(MAKECOOKIE)

install-gdk-pixbuf.loaders:
	@mkdir -p $(DESTDIR)$(sysconfdir)/gtk-2.0
	@rm -f $(DESTDIR)$(sysconfdir)/gtk-2.0/gdk-pixbuf.loaders
	@$(DESTDIR)$(bindir)/gdk-pixbuf-query-loaders > $(DESTDIR)$(sysconfdir)/gtk-2.0/gdk-pixbuf.loaders
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
