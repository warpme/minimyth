GARNAME = libX11
GARVERSION = X11R$(XORG_VERSION)-1.0.0
CATEGORIES = xorg-new
MASTER_SITES = http://xorg.freedesktop.org/releases/X11R$(XORG_VERSION)/src/lib/
DISTFILES = $(DISTNAME).tar.bz2
ifneq ($(DESTIMG),build)
PATCHFILES += $(DISTNAME)-cross.patch
endif
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/COPYING

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c xorg-new/bigreqsproto xorg-new/xproto xorg-new/xextproto xorg-new/xtrans xorg-new/libXau xorg-new/xcmiscproto xorg-new/libXdmcp xorg-new/kbproto xorg-new/inputproto
ifneq ($(DESTIMG),build)
BUILDDEPS += xorg-new/libX11
endif

CONFIGURE_SCRIPTS  = $(WORKSRC)/configure
BUILD_SCRIPTS      = $(WORKSRC)/Makefile
INSTALL_SCRIPTS    = $(WORKSRC)/Makefile
ifeq ($(DESTIMG),build)
INSTALL_SCRIPTS   += build
endif

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

GAR_EXTRA_CONF += xorg-new/xorg/package-api.mk
include ../../gar.mk

install-build:
	install -D $(WORKSRC)/src/util/makekeys $(DESTDIR)$(bindir)/xorg-libX11-makekeys
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/$(GARNAME).la
	@sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'         $(DESTDIR)$(libdir)/pkgconfig/x11.pc
	@sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g' $(DESTDIR)$(libdir)/pkgconfig/x11.pc
	@$(MAKECOOKIE)
