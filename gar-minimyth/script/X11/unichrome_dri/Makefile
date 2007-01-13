GARNAME = Mesa
GARVERSION = 20050203
CATEGORIES = X11
MASTER_SITES = cvs://anonymous@dri.freedesktop.org/cvs/mesa/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME).patch.gar
LICENSE = 

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c X11/X11 kernel/drm

MESA_CONFIG = linux-dri-x86

BUILD_SCRIPTS   = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = custom

BUILD_ARGS = $(MESA_CONFIG)

GAR_EXTRA_CONF += kernel/drm/package-api.mk
include ../../gar.mk

cvs//%$(DISTNAME).tar.bz2:
	@cd $(PARTIALDIR); rm -rf $(GARNAME)
	@cd $(PARTIALDIR); cvs -z3 -d:pserver:$* co -D $(GARVERSION) $(GARNAME)
	@cd $(PARTIALDIR); rm -rf $(DISTNAME)
	@cd $(PARTIALDIR); mv $(GARNAME) $(DISTNAME)
	@cd $(PARTIALDIR); tar -jc $(DISTNAME) -f $(DISTNAME).tar.bz2
	@cd $(PARTIALDIR); rm -rf $(DISTNAME)
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

post-patch:
	@echo "CC = $(CC)"                                                       >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "CXX = $(CXX)"                                                     >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "OPT_FLAGS = $(CFLAGS)"                                            >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "DRM_SOURCE_PATH = $(DRM_SOURCEDIR)"                               >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "MKDEP = $(build_DESTDIR)$(build_x11bindir)/$(GARHOST)-makedepend" >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "SRC_DIRS = mesa"                                                  >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "DRI_DIRS = dri_client unichrome"                                  >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "DRIVER_DIRS = dri"                                                >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@$(MAKECOOKIE)

install-custom:
	@mkdir -p $(DESTDIR)$(x11libdir)/modules/dri
	@rm -f $(DESTDIR)$(x11libdir)/modules/dir/unichrome_dri.* ; \
		cp -fd $(WORKSRC)/lib/unichrome_dri.* $(DESTDIR)$(x11libdir)/modules/dri
	@$(MAKECOOKIE)
