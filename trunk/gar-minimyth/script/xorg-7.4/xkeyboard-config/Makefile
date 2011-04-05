GARNAME = xkeyboard-config
GARVERSION = 2.2
CATEGORIES = $(CATEGORY)
MASTER_SITES  = http://www.x.org/releases/individual/data/$(GARNAME)/
MASTER_SITES += http://xlibs.freedesktop.org/xkbdesc/
MASTER_SITES += http://people.freedesktop.org/~svu/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/COPYING

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c \
	$(CATEGORY)/libX11 \
	$(CATEGORY)/xproto
BUILDDEPS = \
	perl/perl-XML-Parser

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-compat-rules \
	--disable-runtime-deps \
	--enable-nls \
	--with-xkb-base="$(datadir)/X11/xkb" \
	--without-xkb-rules-symlink

CONFIGURE_ENV  = \
	XKBCOMP=$(bindir)/xkbcomp

GAR_EXTRA_CONF += $(CATEGORY)/xorg/package-api.mk
include ../../gar.mk

pre-configure:
	@$(call RUN_AUTOTOOLS)
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)
