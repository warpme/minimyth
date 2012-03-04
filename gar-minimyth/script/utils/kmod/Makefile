GARNAME = kmod
GARVERSION = 6
CATEGORIES = utils
MASTER_SITES = http://ftp.kernel.org/pub/linux/utils/kernel/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = GPL2/LGPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-silent-rules \
	--disable-static \
	--enable-shared \
	--enable-tools \
	--enable-logging \
	--disable-debug \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--with-gnu-ld \
	--without-xz \
	--without-zlib

include ../../gar.mk

bindir  := $(ebindir)
sbindir := $(esbindir)
libdir  := $(elibdir)

pre-configure:
	@$(call RUN_AUTOTOOLS)
	@$(call FIX_LIBTOOL_LIBPATH,$(WORKSRC),configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/$(GARNAME).la
	@$(MAKECOOKIE)
