GARNAME = libdrm
GARVERSION = 20060218
CATEGORIES = xorg
MASTER_SITES  = http://dri.freedesktop.org/libdrm/
MASTER_SITES += cvs://anonymous@dri.freedesktop.org/cvs/dri/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = 

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--with-gnu-ld

GAR_EXTRA_CONF += kernel/drm/package-api.mk
include ../../gar.mk

cvs//%$(DISTNAME).tar.bz2:
	@$(call FETCH_CVS, $*, drm, $(GARVERSION), $(DISTNAME))
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libdrm.la
	@sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'         $(DESTDIR)$(libdir)/pkgconfig/libdrm.pc
	@sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g' $(DESTDIR)$(libdir)/pkgconfig/libdrm.pc
	@$(MAKECOOKIE)
