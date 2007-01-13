GARNAME = libdrm
GARVERSION = 1.0.5
CATEGORIES = kernel
MASTER_SITES  = http://dri.freedesktop.org/libdrm/
MASTER_SITES += cvs://anonymous@dri.freedesktop.org/cvs/dri/
DISTFILES = $(DISTNAME).tar.gz
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
	@cd $(PARTIALDIR); rm -rf $(GARNAME)
	@cd $(PARTIALDIR); cvs -z3 -d:pserver:$* co -D $(GARVERSION) $(GARNAME)
	@cd $(PARTIALDIR); rm -rf $(DISTNAME)
	@cd $(PARTIALDIR); mv $(GARNAME) $(DISTNAME)
	@cd $(PARTIALDIR); tar -zcf $(DISTNAME).tar.gz $(DISTNAME)
	@cd $(PARTIALDIR); rm -rf $(DISTNAME)
	@$(MAKECOOKIE)

disabled-checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

post-patch:
	@cd $(WORKSRC) ; autoreconf --verbose --force
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libdrm.la
	@sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'         $(DESTDIR)$(libdir)/pkgconfig/libdrm.pc
	@sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g' $(DESTDIR)$(libdir)/pkgconfig/libdrm.pc
	@$(MAKECOOKIE)
