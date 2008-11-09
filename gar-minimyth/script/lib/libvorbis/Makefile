GARNAME = libvorbis
GARVERSION = 1.2.0
CATEGORIES = lib
MASTER_SITES = http://downloads.xiph.org/releases/vorbis/
DISTFILES = $(DISTNAME).tar.gz
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

post-patch:
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	rm -f $(DESTDIR)$(libdir)/libvorbis.la
	rm -f $(DESTDIR)$(libdir)/libvorbisenc.la
	rm -f $(DESTDIR)$(libdir)/libvorbisfile.la
	@$(MAKECOOKIE)
