GARNAME = pango
GARVERSION = 1.24.1
CATEGORIES = gtk
MASTER_SITES = http://ftp.gnome.org/pub/GNOME/sources/pango/1.24/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = LGPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c gtk/cairo gtk/glib lib/freetype xorg/xorg

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes="$(DESTDIR)$(includedir)" \
	--x-libraries="$(DESTDIR)$(libdir)" \
	--disable-static \
	--enable-shared \
	--disable-debug \
	--enable-rebuilds \
	--disable-gtk-doc \
	--disable-man \
	--disable-doc-cross-references \
	--enable-explicit-deps=auto \
	--with-gnu-ld \
	--with-x

include ../../gar.mk

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC),configure)
	@$(MAKECOOKIE)

post-install:
	@rm -rf $(DESTDIR)$(libdir)/libpango-1.0.la
	@rm -rf $(DESTDIR)$(libdir)/libpangocairo-1.0.la
	@rm -rf $(DESTDIR)$(libdir)/libpangoft2-1.0.la
	@rm -rf $(DESTDIR)$(libdir)/libpangox-1.0.la
	@rm -rf $(DESTDIR)$(libdir)/libpangoxft-1.0.la
	@rm -rf $(DESTDIR)$(libdir)/pango/1.6.0/modules/pango-arabic-fc.la
	@rm -rf $(DESTDIR)$(libdir)/pango/1.6.0/modules/pango-arabic-lang.la
	@rm -rf $(DESTDIR)$(libdir)/pango/1.6.0/modules/pango-basic-fc.la
	@rm -rf $(DESTDIR)$(libdir)/pango/1.6.0/modules/pango-basic-x.la
	@rm -rf $(DESTDIR)$(libdir)/pango/1.6.0/modules/pango-hangul-fc.la
	@rm -rf $(DESTDIR)$(libdir)/pango/1.6.0/modules/pango-hebrew-fc.la
	@rm -rf $(DESTDIR)$(libdir)/pango/1.6.0/modules/pango-indic-fc.la
	@rm -rf $(DESTDIR)$(libdir)/pango/1.6.0/modules/pango-indic-lang.la
	@rm -rf $(DESTDIR)$(libdir)/pango/1.6.0/modules/pango-khmer-fc.la
	@rm -rf $(DESTDIR)$(libdir)/pango/1.6.0/modules/pango-syriac-fc.la
	@rm -rf $(DESTDIR)$(libdir)/pango/1.6.0/modules/pango-thai-fc.la
	@rm -rf $(DESTDIR)$(libdir)/pango/1.6.0/modules/pango-tibetan-fc.la
	@$(MAKECOOKIE)
