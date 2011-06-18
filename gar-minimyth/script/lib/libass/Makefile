GARNAME = libass
GARVERSION = 0.9.12
CATEGORIES = lib
MASTER_SITES = http://libass.googlecode.com/files/
DISTFILES = $(DISTNAME).tar.gz
#PATCHFILES = $(DISTNAME)-configure.patch $(DISTNAME)-cxxflags.patch $(DISTNAME)-gcc_4.3.patch
LICENSE = libass
libass_LICENSE_TEXT = $(WORKSRC)/COPYING

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/fontconfig lib/freetype

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-shared \
	--disable-static \
	--disable-test \
	--disable-enca \
	--enable-fontconfig \
	--disable-silent-rules \
	--with-gnu-ld \

include ../../gar.mk

pre-configure:
	@$(call RUN_AUTOTOOLS)
	@$(call FIX_LIBTOOL_LIBPATH,$(WORKSRC),configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libass.la
	@$(MAKECOOKIE)
