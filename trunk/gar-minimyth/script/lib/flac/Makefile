GARNAME = flac
GARVERSION = 1.2.1
CATEGORIES = lib
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-gcc_4.3.patch
LICENSE = GPL2/LGPL2_1/FDL1_2/xiph
xiph_LICENSE_TEXT = $(WORKSRC)/COPYING.Xiph

DESCRIPTION =
define BLURB
endef

DEPENDS   = lang/c lib/libogg
BUILDDEPS = devel/nasm

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-shared \
	--disable-static \
	--disable-altivec \
	--disable-doxygen-docs \
	--disable-xmms-plugin \
	--disable-oggtest \
	--disable-rpath \
	--with-gnu-ld \
	--with-ogg-includes=$(DESTDIR)$(includedir) \
	--with-ogg-libraries=$(DESTDIR)$(libdir)

include ../../gar.mk

pre-configure:
	@$(call FIX_LIBTOOL_LIBPATH,$(WORKSRC),configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libFLAC.la
	@rm -f $(DESTDIR)$(libdir)/libFLAC++.la
	@rm -f $(DESTDIR)$(libdir)/libOggFLAC.la
	@rm -f $(DESTDIR)$(libdir)/libOggFLAC++.la
	@$(MAKECOOKIE)
