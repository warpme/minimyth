GARNAME = unichrome_dri
GARVERSION = 6.3.2
CATEGORIES = X11
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/mesa3d/
DISTFILES = MesaLib-$(GARVERSION).tar.bz2
PATCHFILES = Mesa-$(GARVERSION).patch.gar
LICENSE = 

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c X11/X11 lib/libdrm

WORKSRC = $(WORKDIR)/Mesa-$(GARVERSION)

MESA_CONFIG = linux-dri-x86

CONFIGURE_SCRIPTS = custom
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = custom

GAR_EXTRA_CONF += kernel/drm/package-api.mk
include ../../gar.mk

configure-custom:
	@echo "CC = $(CC)"                                                       >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "CXX = $(CXX)"                                                     >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "OPT_FLAGS = $(CFLAGS)"                                            >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "MKDEP = $(build_DESTDIR)$(build_x11bindir)/$(GARHOST)-makedepend" >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "DRI_DIRS = unichrome"                                             >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "DRIVER_DIRS = dri"                                                >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@ln -sf $(MESA_CONFIG) $(WORKSRC)/configs/current
	@$(MAKECOOKIE)

install-custom:
	@mkdir -p $(DESTDIR)$(x11libdir)
	@cp -fd $(WORKSRC)/lib/libGL.*         $(DESTDIR)$(x11libdir)/
	@mkdir -p $(DESTDIR)$(x11libdir)/modules/dri/
	@cp -fd $(WORKSRC)/lib/unichrome_dri.* $(DESTDIR)$(x11libdir)/modules/dri/
	@$(MAKECOOKIE)
