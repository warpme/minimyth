GARNAME = Mesa
GARVERSION = 6.4.2
CATEGORIES = xorg
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/mesa3d/
DISTFILES = MesaLib-$(GARVERSION).tar.bz2 MesaGLUT-$(GARVERSION).tar.bz2 MesaDemos-$(GARVERSION).tar.bz2
PATCHFILES = $(DISTNAME)-gen_matypes.patch $(DISTNAME).patch.gar $(DISTNAME)-xdemos.patch
LICENSE = 

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c++ lib/expat xorg/libdrm xorg/xproto xorg/libX11 xorg/glproto xorg/xf86vidmodeproto xorg/libXext xorg/libXxf86vm xorg/libXmu xorg/libXi
BUILDDEPS = xorg/makedepend

MESA_CONFIG = $(strip \
	$(if $(filter i386  ,$(GARCH_FAMILY)),linux-dri-x86   ) \
	$(if $(filter x86_64,$(GARCH_FAMILY)),linux-dri-x86-64))
MESA_LIBDIR = $(strip \
	$(if $(filter i386  ,$(GARCH_FAMILY)),lib  ) \
	$(if $(filter x86_64,$(GARCH_FAMILY)),lib64))

CONFIGURE_SCRIPTS = custom
BUILD_SCRIPTS     = $(WORKSRC)/Makefile $(WORKSRC)/progs/xdemos/Makefile
INSTALL_SCRIPTS   = custom source

BUILD_ARGS = \
	BUILD_CC="$(build_CC)" \
	BUILD_CFLAGS="$(build_CFLAGS)"

include ../../gar.mk

configure-custom:
	@echo "CC = $(CC) -Wl,-z,noexecstack"                      >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "CXX = $(CXX)"                                       >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "OPT_FLAGS = $(CFLAGS)"                              >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "MKDEP = $(build_DESTDIR)$(build_bindir)/makedepend" >> $(WORKSRC)/configs/$(MESA_CONFIG)
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
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/dri/i810_dri.* ; \
		$(if $(filter i386,$(GARCH_FAMILY)), \
			cp -fd $(WORKSRC)/$(MESA_LIBDIR)/i810_dri.*      $(DESTDIR)$(libdir)/xorg/modules/dri/)
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/dri/i830_dri.* ; \
		$(if $(filter i386,$(GARCH_FAMILY)), \
			cp -fd $(WORKSRC)/$(MESA_LIBDIR)/i830_dri.*      $(DESTDIR)$(libdir)/xorg/modules/dri/)
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/dri/i915_dri.* ; \
		cp -fd $(WORKSRC)/$(MESA_LIBDIR)/i915_dri.*      $(DESTDIR)$(libdir)/xorg/modules/dri/
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/dri/unichrome_dri.* ; \
		cp -fd $(WORKSRC)/$(MESA_LIBDIR)/unichrome_dri.* $(DESTDIR)$(libdir)/xorg/modules/dri/
	@mkdir -p $(DESTDIR)$(bindir)
	@rm -f $(DESTDIR)$(bindir)/glxgears ; \
		cp -fd $(WORKSRC)/progs/xdemos/glxgears $(DESTDIR)$(bindir)/
	@rm -f $(DESTDIR)$(bindir)/glxinfo ; \
		cp -fd $(WORKSRC)/progs/xdemos/glxinfo $(DESTDIR)$(bindir)/
	@$(MAKECOOKIE)

install-source:
	@mkdir -p $(DESTDIR)$(sourcedir)
	@ln -sf $(mm_HOME)/script/xorg/Mesa/$(WORKSRC) $(DESTDIR)$(sourcedir)/Mesa
	@$(MAKECOOKIE)
