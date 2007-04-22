GARNAME = libdca
GARVERSION = 0.0.5
CATEGORIES = lib
MASTER_SITES = http://download.videolan.org/pub/videolan/libdca/$(GARVERSION)/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-debug \
	--disable-fixed \
	--disable-double \
	--disable-oss \
	--disable-solaris-audio \
	--disable-al-audio \
	--disable-win \
	--disable-warnings \
	--disable-gprof \
	--with-gnu-ld

include ../../gar.mk

post-install:
	@sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'         $(DESTDIR)$(libdir)/pkgconfig/libdca.pc
	@sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g' $(DESTDIR)$(libdir)/pkgconfig/libdca.pc
	@sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'         $(DESTDIR)$(libdir)/pkgconfig/libdts.pc
	@sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g' $(DESTDIR)$(libdir)/pkgconfig/libdts.pc
	@rm -rf $(DESTDIR)$(libdir)/libdts.a
	@ln -sf "libdca.a" "$(DESTDIR)$(libdir)/libdts.a"
	@$(MAKECOOKIE)
