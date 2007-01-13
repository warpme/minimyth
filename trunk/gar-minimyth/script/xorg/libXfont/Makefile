GARNAME = libXfont
GARVERSION = 1.0.0
CATEGORIES = xorg
MASTER_SITES = http://xorg.freedesktop.org/releases/X11R$(XORG_VERSION)/src/lib/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE =

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c xorg/xproto xorg/xtrans xorg/fontsproto xorg/libfontenc X11/freetype

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-freetype \
	--disable-type1 \
	--disable-cid \
	--disable-speedo \
	--enable-builtins \
	--disable-pcfformat \
	--disable-bdfformat \
	--disable-snfformat \
	--disable-fontcache \
	--enable-fc \
	--enable-unix-transport \
	--enable-tcp-transport \
	--disable-ipv6 \
	--with-gnu-ld \
	--with-freetype-config="$(DESTDIR)$(bindir)/freetype-config"

GAR_EXTRA_CONF += xorg/xorg/package-api.mk
include ../../gar.mk
include ../xorg.mk

post-install:
	@rm -f $(DESTDIR)$(x11libdir)/$(GARNAME).la
	@sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'         $(DESTDIR)$(x11libdir)/pkgconfig/xfont.pc
	@sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g' $(DESTDIR)$(x11libdir)/pkgconfig/xfont.pc
	@$(MAKECOOKIE)
