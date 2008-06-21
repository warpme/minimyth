GARNAME = lame
GARVERSION = 3.97
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
	--enable-nasm \
	--with-gnu-ld \
	--with-gtk-prefix="$(DESTDIR)$(prefix)" \
	--with-gtk-exec-prefix="$(DESTDIR)$(exec_prefix)"

include ../../gar.mk

LDFLAGS += -lm

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
