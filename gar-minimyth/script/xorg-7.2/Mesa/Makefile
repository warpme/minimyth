GARNAME = Mesa
GARVERSION = 6.5.1
CATEGORIES = $(CATEGORY)
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/mesa3d/
DISTFILES = MesaLib-$(GARVERSION).tar.bz2 MesaGLUT-$(GARVERSION).tar.bz2 MesaDemos-$(GARVERSION).tar.bz2
PATCHFILES = $(DISTNAME)-gen_matypes.patch $(DISTNAME).patch.gar $(DISTNAME)-xdemos.patch
LICENSE = LGPL2/MIT

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c++ lib/expat \
	$(CATEGORY)/glproto \
	$(CATEGORY)/libdrm \
	$(CATEGORY)/libX11 \
	$(CATEGORY)/libXext \
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
	$(if $(filter i386  ,$(GARCH_FAMILY)),i810 i915 i965 unichrome) \
	$(if $(filter x86_64,$(GARCH_FAMILY)),     i915 i965 unichrome))

CONFIGURE_SCRIPTS = custom
BUILD_SCRIPTS     = $(WORKSRC)/Makefile $(WORKSRC)/progs/xdemos/Makefile
INSTALL_SCRIPTS   = custom source

BUILD_ARGS = \
	BUILD_CC="$(build_CC)" \
	BUILD_CFLAGS="$(build_CFLAGS)"

include ../../gar.mk

CFLAGS   := $(patsubst -O%,,$(CFLAGS)  ) -O2
CXXFLAGS := $(patsubst -O%,,$(CXXFLAGS)) -O2

configure-custom:
	@echo "CC = $(CC) -Wl,-z,noexecstack"                      >> $(WORKSRC)/configs/$(MESA_CONFIG)
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
	@ln -sf $(PWD)/$(WORKSRC) $(DESTDIR)$(sourcedir)/Mesa
	@$(MAKECOOKIE)
