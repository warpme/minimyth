GARNAME = libvorbis
GARVERSION = 1.3.1
CATEGORIES = lib
MASTER_SITES = http://downloads.xiph.org/releases/vorbis/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-configure.patch
LICENSE = xiph
xiph_LICENSE_TEXT = $(WORKSRC)/COPYING

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/libogg

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-shared \
	--disable-static \
	--disable-docs \
	--disable-oggtest \
	--with-gnu-ld

include ../../gar.mk

# Fails to compile with GCC's Os optimization, so convert it to O2 optimization.
CFLAGS := $(if $(filter -Os, $(CFLAGS)), $(filter-out -O%, $(CFLAGS)) -O2)

pre-configure:
	@cd $(WORKSRC) ; rm -f m4/ogg.m4
	@cd $(WORKSRC) ; rm -f m4/pkg.m4
	@$(call RUN_AUTOTOOLS)
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	rm -f $(DESTDIR)$(libdir)/libvorbis.la
	rm -f $(DESTDIR)$(libdir)/libvorbisenc.la
	rm -f $(DESTDIR)$(libdir)/libvorbisfile.la
	@$(MAKECOOKIE)
