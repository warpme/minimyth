GARNAME = libX11
GARVERSION = 1.6.3
CATEGORIES = $(CATEGORY)
MASTER_SITES = $(XORG_MASTER_SITES)
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES  = \
	$(DISTNAME)-pkg_config.patch \
	$(DISTNAME)-disable_nls_tests.patch
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/COPYING

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c \
	$(CATEGORY)/inputproto \
	$(CATEGORY)/kbproto \
	$(CATEGORY)/libxcb \
	$(CATEGORY)/util-macros \
	$(CATEGORY)/xextproto \
	$(CATEGORY)/xf86bigfontproto \
	$(CATEGORY)/xproto \
	$(CATEGORY)/xtrans
BUILDDEPS = \
	$(CATEGORY)/xorg-sgml-doctools

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

CONFIGURE_SCRIPTS  = $(WORKSRC)/configure
BUILD_SCRIPTS      = $(WORKSRC)/Makefile
INSTALL_SCRIPTS    = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-silent-rules \
	--enable-shared \
	--disable-static \
	--enable-unix-transport \
	--disable-tcp-transport \
	--disable-ipv6 \
	--disable-local-transport \
	--disable-secure-rpc \
	--disable-loadable-i18n \
	--enable-loadable-xcursor \
	--enable-xthreads \
	--disable-xcms \
	--enable-xlocale \
	--disable-xlocaledir \
	--enable-xf86bigfont \
	--enable-xkb \
	--disable-composecache \
	--enable-malloc0returnsnull \
	--without-xmlto \
	--without-fop \
	--with-gnu-ld \
	--without-launchd

CONFIGURE_ENV = \
	CC_FOR_BUILD="$(build_CC)" \
	CPPFLAGS_FOR_BUILD="$(build_CPPFLAGS)" \
	CFLAGS_FOR_BUILD="$(build_CFLAGS)" \
	LDFLAGS_FOR_BUILD="$(build_LDFLAGS)"

GAR_EXTRA_CONF += $(CATEGORY)/xorg/package-api.mk
include ../../gar.mk

pre-configure:
	@$(call RUN_AUTOTOOLS)
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/$(GARNAME).la
	@rm -f $(DESTDIR)$(libdir)/$(GARNAME)-xcb.la
	@$(MAKECOOKIE)
