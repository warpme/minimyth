GARNAME = libX11
GARVERSION = 1.0.0
CATEGORIES = xorg
MASTER_SITES = http://xorg.freedesktop.org/releases/X11R$(XORG_VERSION)/src/lib/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE =

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c xorg/bigreqsproto xorg/xproto xorg/xextproto xorg/xtrans xorg/libXau xorg/xcmiscproto xorg/libXdmcp xorg/kbproto xorg/inputproto

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-secure-rpc \
	--disable-loadable-i18n \
	--enable-loadable-xcursor \
	--enable-xthreads \
	--enable-xcms \
	--enable-xlocale \
	--disable-xlocaledir \
	--enable-xf86bigfont \
	--enable-xkb \
	--disable-man-pages \
	--enable-unix-transport \
	--enable-tcp-transport \
	--disable-ipv6 \
	--enable-malloc0returnsnull \
	--with-gnu-ld

GAR_EXTRA_CONF += xorg/xorg/package-api.mk
include ../../gar.mk
include ../xorg.mk

post-install:
	@rm -f $(DESTDIR)$(x11libdir)/$(GARNAME).la
	@sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'         $(DESTDIR)$(x11libdir)/pkgconfig/x11.pc
	@sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g' $(DESTDIR)$(x11libdir)/pkgconfig/x11.pc
	@$(MAKECOOKIE)
