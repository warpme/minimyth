GARNAME = Mesa
GARVERSION = 6.3.2
CATEGORIES = X11
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/mesa3d/
DISTFILES = MesaLib-$(GARVERSION).tar.bz2
PATCHFILES = $(DISTNAME).patch.gar
LICENSE = 

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c X11/X11 lib/libdrm

MESA_CONFIG = linux-dri-x86

CONFIGURE_SCRIPTS = custom
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = custom

BUILD_ARGS = $(MESA_CONFIG)

GAR_EXTRA_CONF += kernel/drm/package-api.mk
include ../../gar.mk

configure-custom:
	@echo "CC = $(CC)"                                                       >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "CXX = $(CXX)"                                                     >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "OPT_FLAGS = $(CFLAGS)"                                            >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@#echo "DRM_SOURCE_PATH = $(DRM_SOURCEDIR)"                               >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "MKDEP = $(build_DESTDIR)$(build_x11bindir)/$(GARHOST)-makedepend" >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "DRI_DIRS = unichrome"                                             >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "DRIVER_DIRS = dri"                                                >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@$(MAKECOOKIE)

install-custom:
	@mkdir -p $(DESTDIR)$(x11includedir)/GL
	@cp -fd $(WORKSRC)/include/GL/*.h $(DESTDIR)$(x11includedir)/GL/
	@cp -fd $(WORKSRC)/src/glw/*.h    $(DESTDIR)$(x11includedir)/GL/
	@mkdir -p $(DESTDIR)$(x11libdir)
	@rm -f $(DESTDIR)$(x11libdir)/libGL.* ; \
		cp -fd $(WORKSRC)/lib/libGL.* $(DESTDIR)$(x11libdir)/
	@rm -f $(DESTDIR)$(x11libdir)/libGLU.* ; \
		cp -fd $(WORKSRC)/lib/libGLU.* $(DESTDIR)$(x11libdir)/
	@rm -f $(DESTDIR)$(x11libdir)/libGLw.* ; \
		cp -fd $(WORKSRC)/lib/libGLw.* $(DESTDIR)$(x11libdir)/
	@mkdir -p $(DESTDIR)$(x11libdir)/modules/dri
	@rm -f $(DESTDIR)$(x11libdir)/modules/dri/unichrome_dri.* ; \
		cp -fd $(WORKSRC)/lib/unichrome_dri.* $(DESTDIR)$(x11libdir)/modules/dri/
	@$(MAKECOOKIE)
