GARNAME = lame
GARVERSION = 398-2
CATEGORIES = lib
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz config.cache.$(GARCH_FAMILY)
LICENSE = LGPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c lib/ncurses
BUILDDEPS = devel/nasm

PWD := $(shell pwd)

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--cache-file=config.cache \
	--enable-shared \
	--disable-static \
	--enable-nasm \
	--disable-cpml \
	--with-gnu-ld

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

post-install:
	@rm -f $(DESTDIR)$(libdir)/libmp3lame.la
	@$(MAKECOOKIE)
