GARNAME = Mesa
GARVERSION = 6.4.1
CATEGORIES = xorg
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/mesa3d/
DISTFILES = MesaLib-$(GARVERSION).tar.bz2 MesaGLUT-$(GARVERSION).tar.bz2 MesaDemos-$(GARVERSION).tar.bz2
PATCHFILES = $(DISTNAME).patch.gar $(DISTNAME)-xdemos.patch
LICENSE = 

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c lib/expat xorg/libdrm xorg/xproto xorg/libX11 xorg/glproto xorg/xf86vidmodeproto xorg/libXext xorg/libXxf86vm xorg/libXmu xorg/libXi
BUILDDEPS = xorg/makedepend

MESA_CONFIG = linux-dri-x86

CONFIGURE_SCRIPTS = custom
BUILD_SCRIPTS     = $(WORKSRC)/Makefile $(WORKSRC)/progs/xdemos/Makefile
INSTALL_SCRIPTS   = custom source

include ../../gar.mk

configure-custom:
	@echo "CC = $(CC)"                                            >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "CXX = $(CXX)"                                          >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "OPT_FLAGS = $(CFLAGS)"                                 >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "MKDEP = $(build_DESTDIR)$(build_x11bindir)/makedepend" >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "DRI_DIRS = unichrome"                                  >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@echo "DRIVER_DIRS = dri"                                     >> $(WORKSRC)/configs/$(MESA_CONFIG)
	@ln -sf $(MESA_CONFIG) $(WORKSRC)/configs/current
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
	@rm -f $(DESTDIR)$(x11libdir)/libglut.* ; \
		cp -fd $(WORKSRC)/lib/libglut.* $(DESTDIR)$(x11libdir)/
	@rm -f $(DESTDIR)$(x11libdir)/libGLw.* ; \
		cp -fd $(WORKSRC)/lib/libGLw.* $(DESTDIR)$(x11libdir)/
	@mkdir -p $(DESTDIR)$(x11libdir)/xorg/modules/dri
	@rm -f $(DESTDIR)$(x11libdir)/xorg/modules/dri/unichrome_dri.* ; \
		cp -fd $(WORKSRC)/lib/unichrome_dri.* $(DESTDIR)$(x11libdir)/xorg/modules/dri/
	@mkdir -p $(DESTDIR)$(x11bindir)
	@rm -f $(DESTDIR)$(x11bindir)/glxgears ; \
		cp -fd $(WORKSRC)/progs/xdemos/glxgears $(DESTDIR)$(x11bindir)/
	@rm -f $(DESTDIR)$(x11bindir)/glxinfo ; \
		cp -fd $(WORKSRC)/progs/xdemos/glxinfo $(DESTDIR)$(x11bindir)/
	@$(MAKECOOKIE)

install-source:
	@mkdir -p $(DESTDIR)$(sourcedir)
	@ln -sf $(mm_HOME)/script/xorg/Mesa/$(WORKSRC) $(DESTDIR)$(sourcedir)/Mesa
	@$(MAKECOOKIE)
