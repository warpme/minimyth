GARNAME = unichrome_dri
GARVERSION = 6.3.2
CATEGORIES = X11
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/mesa3d/
DISTFILES = MesaLib-$(GARVERSION).tar.bz2
PATCHFILES = Mesa-$(GARVERSION).patch.gar Mesa-$(GARVERSION)-gen_matypes.patch
LICENSE = 

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c X11/X11 lib/libdrm

WORKSRC = $(WORKDIR)/Mesa-$(GARVERSION)

MESA_CONFIG = $(strip \
	$(if $(filter i386  ,$(GARCH_FAMILY)),linux-dri-x86   ) \
	$(if $(filter x86_64,$(GARCH_FAMILY)),linux-dri-x86-64))
MESA_LIBDIR = $(strip \
	$(if $(filter i386  ,$(GARCH_FAMILY)),lib  ) \
	$(if $(filter x86_64,$(GARCH_FAMILY)),lib64))

CONFIGURE_SCRIPTS = custom
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = custom

BUILD_ARGS = \
	BUILD_CC="$(build_CC)" \
	BUILD_CFLAGS="$(build_CFLAGS)"

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
	@cp -fd $(WORKSRC)/$(MESA_LIBDIR)/libGL.*         $(DESTDIR)$(x11libdir)/
	@mkdir -p $(DESTDIR)$(x11libdir)/modules/dri/
	@cp -fd $(WORKSRC)/$(MESA_LIBDIR)/unichrome_dri.* $(DESTDIR)$(x11libdir)/modules/dri/
	@$(MAKECOOKIE)
