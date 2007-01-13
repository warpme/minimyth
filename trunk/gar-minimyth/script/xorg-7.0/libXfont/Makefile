GARNAME = libXfont
GARVERSION = X11R$(XORG_VERSION)-1.0.0
CATEGORIES = xorg-7.0
MASTER_SITES = http://xorg.freedesktop.org/releases/X11R$(XORG_VERSION)/src/lib/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-freetype_internal.patch
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/COPYING

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c xorg-7.0/xproto xorg-7.0/xtrans xorg-7.0/fontsproto xorg-7.0/libfontenc lib/freetype

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

GAR_EXTRA_CONF += xorg-7.0/xorg/package-api.mk
include ../../gar.mk

post-install:
	@rm -f $(DESTDIR)$(libdir)/$(GARNAME).la
	@sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'         $(DESTDIR)$(libdir)/pkgconfig/xfont.pc
	@sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g' $(DESTDIR)$(libdir)/pkgconfig/xfont.pc
	@$(MAKECOOKIE)
