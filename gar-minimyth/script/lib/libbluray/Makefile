GARNAME = libbluray
GARVERSION = 250f606
CATEGORIES = lib
MASTER_SITES = git://git.videolan.org/libbluray.git/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(GARNAME)-configure.patch
LICENSE = LGPL2_1

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c lib/libxml2
BUILDDEPS =

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-werror \
	--disable-extra-warnings \
	--disable-optimizations \
	--disable-examples \
	--disable-debug \
	--disable-bdjava \
	--enable-shared \
	--enable-static \
	--disable-doxygen-doc \
	--disable-doxygen-dot \
	--disable-doxygen-man \
	--disable-doxygen-rtf \
	--disable-doxygen-xml \
	--disable-doxygen-chm \
	--disable-doxygen-chi \
	--disable-doxygen-html \
	--disable-doxygen-ps \
	--disable-doxygen-pdf \
	--with-dlopen-crypto-libs \
	--with-gnu-ld

include ../../gar.mk

git//%$(DISTNAME).tar.bz2:
	@$(call FETCH_GIT, $*, $(GARVERSION), $(DISTNAME))
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE) 

pre-configure:
	@$(call RUN_AUTOTOOLS)
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/$(GARNAME).a
	@rm -f $(DESTDIR)$(libdir)/$(GARNAME).la
	@$(MAKECOOKIE)