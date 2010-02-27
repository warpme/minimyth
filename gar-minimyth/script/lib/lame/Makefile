GARNAME = lame
GARVERSION = 3.98.3
CATEGORIES = lib
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES  = $(DISTNAME).tar.gz
DISTFILES += config.cache.$(GARCH_FAMILY)
LICENSE = LGPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c lib/ncurses
BUILDDEPS = devel/nasm

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--cache-file=config.cache \
	--enable-shared \
	--disable-static \
	--enable-nasm \
	--disable-cpml \
	--disable-gtktest \
	--disable-efence \
	--disable-analyzer-hooks \
	--enable-decoder \
	--enable-decode-layer1 \
	--enable-decode-layer2 \
	--disable-frontend \
	--disable-mp3x \
	--disable-mp3rtp \
	--disable-brhist \
	--disable-all-float \
	--enable-expopt=no \
	--enable-debug=no \
	--with-gnu-ld \
	--with-fileio=lame

CONFIGURE_ENV = \
	GTK_CONFIG='no'

include ../../gar.mk

PARALLELMFLAGS := -j1

extract-config.cache.$(GARCH_FAMILY):
	@cp $(DOWNLOADDIR)/config.cache.$(GARCH_FAMILY) $(WORKSRC)/config.cache
	@$(MAKECOOKIE)

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

x-post-install:
	@rm -f $(DESTDIR)$(libdir)/libmp3lame.la
	@$(MAKECOOKIE)
