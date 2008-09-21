GARNAME = Mesa
GARVERSION = 7.0.4
CATEGORIES = $(CATEGORY)
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/mesa3d/
DISTFILES = MesaLib-$(GARVERSION).tar.bz2 MesaGLUT-$(GARVERSION).tar.bz2 MesaDemos-$(GARVERSION).tar.bz2
PATCHFILES = $(DISTNAME)-ticket-13541.patch $(DISTNAME)-pkg_config.patch $(DISTNAME)-gen_matypes.patch $(DISTNAME).patch.gar
LICENSE = LGPL2/MIT

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c++ lib/expat \
	$(CATEGORY)/glproto \
	$(CATEGORY)/libdrm \
	$(CATEGORY)/libX11 \
	$(CATEGORY)/libXdamage \
	$(CATEGORY)/libXext \
	$(CATEGORY)/libXfixes \
	$(CATEGORY)/libXi \
	$(CATEGORY)/libXmu \
	$(CATEGORY)/libXxf86vm \
	$(CATEGORY)/xf86vidmodeproto \
	$(CATEGORY)/xproto
BUILDDEPS = $(CATEGORY)/makedepend

PWD := $(shell pwd)
CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

MESA_CONFIG = $(strip \
	$(if $(filter i386  ,$(GARCH_FAMILY)),linux-dri-x86   ) \
	$(if $(filter x86_64,$(GARCH_FAMILY)),linux-dri-x86-64))
MESA_LIBDIR = $(strip \
	$(if $(filter i386  ,$(GARCH_FAMILY)),lib  ) \
	$(if $(filter x86_64,$(GARCH_FAMILY)),lib64))
DRI_DIRS    = $(strip \
	$(if $(filter i386  ,$(GARCH_FAMILY)),i810 i915 i965 r200 r300 radeon savage sis unichrome) \
	$(if $(filter x86_64,$(GARCH_FAMILY)),     i915 i965 r200 r300 radeon savage sis unichrome))

CONFIGURE_SCRIPTS = custom
BUILD_SCRIPTS     = $(WORKSRC)/Makefile $(WORKSRC)/progs/xdemos/Makefile
INSTALL_SCRIPTS   = custom source

BUILD_ARGS = \
	BUILD_CC="$(build_CC)" \
	BUILD_CFLAGS="$(build_CFLAGS)"

include ../../gar.mk

configure-custom:
	@# Inclusion of assembly code causes the unichome_dri driver to segfault.
	@# Disabling assembly code is a performance hit, but we do not need top GL performance for Myth.
	@echo "ASM_FLAGS ="                                        >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "ASM_SOURCES ="                                      >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "ASM_API ="                                          >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "PKG_CONFIG = pkg-config"                            >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "CC = $(CC)"                                         >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "CXX = $(CXX)"                                       >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "OPT_FLAGS = $(CFLAGS)"                              >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "MKDEP = $(build_DESTDIR)$(build_bindir)/makedepend" >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "DRI_DIRS = $(DRI_DIRS)"                             >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "PROGRAM_DIRS = xdemos"                              >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@ln -sf $(MESA_CONFIG) $(WORKSRC)/configs/current
	@$(MAKECOOKIE)

install-custom:
	@mkdir -p $(DESTDIR)$(includedir)/GL
	@cp -fd $(WORKSRC)/include/GL/*.h $(DESTDIR)$(includedir)/GL/
	@cp -fd $(WORKSRC)/src/glw/*.h    $(DESTDIR)$(includedir)/GL/
	@mkdir -p $(DESTDIR)$(libdir)
	@rm -f $(DESTDIR)$(libdir)/libGL.* ; \
		cp -fd $(WORKSRC)/$(MESA_LIBDIR)/libGL.* $(DESTDIR)$(libdir)/
	@rm -f $(DESTDIR)$(libdir)/libGLU.* ; \
		cp -fd $(WORKSRC)/$(MESA_LIBDIR)/libGLU.* $(DESTDIR)$(libdir)/
	@rm -f $(DESTDIR)$(libdir)/libglut.* ; \
		cp -fd $(WORKSRC)/$(MESA_LIBDIR)/libglut.* $(DESTDIR)$(libdir)/
	@rm -f $(DESTDIR)$(libdir)/libGLw.* ; \
		cp -fd $(WORKSRC)/$(MESA_LIBDIR)/libGLw.* $(DESTDIR)$(libdir)/
	@mkdir -p $(DESTDIR)$(libdir)/xorg/modules/dri
	@rm -rf $(DESTDIR)$(libdir)/xorg/modules/dri
	@mkdir -p $(DESTDIR)$(libdir)/xorg/modules/dri
	@cp -fd $(WORKSRC)/$(MESA_LIBDIR)/*_dri.* $(DESTDIR)$(libdir)/xorg/modules/dri/
	@mkdir -p $(DESTDIR)$(bindir)
	@rm -f $(DESTDIR)$(bindir)/glxgears ; \
		cp -fd $(WORKSRC)/progs/xdemos/glxgears $(DESTDIR)$(bindir)/
	@rm -f $(DESTDIR)$(bindir)/glxinfo ; \
		cp -fd $(WORKSRC)/progs/xdemos/glxinfo $(DESTDIR)$(bindir)/
	@$(MAKECOOKIE)

install-source:
	@mkdir -p $(DESTDIR)$(sourcedir)
	@rm -f $(DESTDIR)$(sourcedir)/Mesa
	@ln -sf $(PWD)/$(WORKSRC) $(DESTDIR)$(sourcedir)/Mesa
	@$(MAKECOOKIE)
