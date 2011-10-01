GARNAME = fribidi
GARVERSION = 0.19.2
CATEGORIES = lib
MASTER_SITES = http://fribidi.org/download/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = LGPL2_1

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-shared \
	--disable-static \
	--disable-debug \
	--disable-deprecated \
	--disable-malloc \
	--enable-charsets \
	--with-gnu-ld \
	--without-glib

include ../../gar.mk

pre-configure:
	@$(call RUN_AUTOTOOLS)
	@$(call FIX_LIBTOOL_LIBPATH,$(WORKSRC),configure)
	@$(MAKECOOKIE)

x-post-install:
	@rm -f $(DESTDIR)$(libdir)/libfribidi.la
	@$(MAKECOOKIE)
