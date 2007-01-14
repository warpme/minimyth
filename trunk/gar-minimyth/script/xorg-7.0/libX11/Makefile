GARNAME = libX11
GARVERSION = 1.0.0
CATEGORIES = $(CATEGORY)
MASTER_SITES = $(XORG_MASTER_SITES)
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-cross.patch
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/COPYING

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c \
	$(CATEGORY)/bigreqsproto \
	$(CATEGORY)/inputproto \
	$(CATEGORY)/kbproto \
	$(CATEGORY)/libXau \
	$(CATEGORY)/libXdmcp \
	$(CATEGORY)/xcmiscproto \
	$(CATEGORY)/xextproto \
	$(CATEGORY)/xf86bigfontproto \
	$(CATEGORY)/xproto \
	$(CATEGORY)/xtrans

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

CONFIGURE_SCRIPTS  = $(WORKSRC)/configure
BUILD_SCRIPTS      = $(WORKSRC)/Makefile
INSTALL_SCRIPTS    = $(WORKSRC)/Makefile

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
	--enable-malloc0returnsnull \
	--enable-unix-transport \
	--enable-tcp-transport \
	--disable-ipv6 \
	--with-gnu-ld

GAR_EXTRA_CONF += $(CATEGORY)/xorg/package-api.mk
include ../../gar.mk

CFLAGS   := $(patsubst -O%,,$(CFLAGS)  ) -O2
CXXFLAGS := $(patsubst -O%,,$(CXXFLAGS)) -O2

pre-configure:
	@cd $(WORKSRC) ; autoconf     --verbose
	@cd $(WORKSRC) ; automake-1.7 --verbose
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/$(GARNAME).la
	@sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'         $(DESTDIR)$(libdir)/pkgconfig/x11.pc
	@sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g' $(DESTDIR)$(libdir)/pkgconfig/x11.pc
	@$(MAKECOOKIE)
