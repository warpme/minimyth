GARNAME = Mesa
GARVERSION = 7.11.2
CATEGORIES = $(CATEGORY)
MASTER_SITES  = ftp://ftp.freedesktop.org/pub/mesa/beta/
MASTER_SITES += ftp://ftp.freedesktop.org/pub/mesa/$(GARVERSION)/
DISTFILES = MesaLib-$(GARVERSION).tar.bz2
PATCHFILES  = $(DISTNAME)-llvm_3.0.patch $(DISTNAME)-llvm_so.patch $(DISTNAME)-pkg_config.patch $(DISTNAME).patch.gar
PATCHFILES += $(DISTNAME)-version.patch
ifneq ($(DESTIMG),build)
PATCHFILES += $(DISTNAME)-cross.patch
endif
LICENSE = LGPL2/MIT

DESCRIPTION = 
define BLURB
endef

DEPENDS    = lang/c lang/cxx devel/llvm lib/expat \
	$(CATEGORY)/dri2proto \
	$(CATEGORY)/xextproto \
	$(CATEGORY)/glproto \
	$(CATEGORY)/libdrm \
	$(CATEGORY)/libX11 \
	$(CATEGORY)/libxcb \
	$(CATEGORY)/libXdamage \
	$(CATEGORY)/libXext \
	$(CATEGORY)/libXfixes \
	$(CATEGORY)/libXi \
	$(CATEGORY)/libXmu \
	$(CATEGORY)/libXxf86vm \
	$(CATEGORY)/libXt
ifneq ($(DESTIMG),build)
DEPENDS   += system/udev
endif
BUILDDEPS  = lib/libxml2 python/python \
	$(CATEGORY)/makedepend
ifneq ($(DESTIMG),build)
BUILDDEPS += $(CATEGORY)/Mesa
endif

PWD := $(shell pwd)
CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

CONFIGURE_SCRIPTS  = $(WORKSRC)/configure
BUILD_SCRIPTS      = $(WORKSRC)/Makefile
INSTALL_SCRIPTS    = $(WORKSRC)/Makefile source
ifeq ($(DESTIMG),build)
INSTALL_SCRIPTS   += cross
endif

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes="$(DESTDIR)$(includedir)" \
	--x-libraries="$(DESTDIR)$(libdir)" \
	--disable-static \
	--enable-shared \
	--disable-texture-float \
	--disable-selinux \
	--enable-opengl \
	--disable-gles1 \
	--disable-gles2 \
	--disable-openvg \
	--disable-xorg \
	--disable-d3d1x \
	--disable-egl \
	--disable-gbm \
	--disable-gallium-egl \
	--disable-gallium-gbm \
	--disable-shared-glapi \
	--enable-xcb \
	--enable-shared-dricore \
	--disable-egl \
	--enable-gallium-llvm \
	--with-gallium-drivers="i915,i965,nouveau,r300,r600,svga,swrast" \
	--with-driver="dri" \
	--with-x \
	--with-dri-driverdir="$(libdir)/xorg/modules/dri" \
	--with-dri-drivers="$(DRI_DIRS)" \
	--with-state-trackers="dri,glx"

BUILD_ARGS  = \
	HOST_CC="$(build_CC)" \
	HOST_CFLAGS="$(build_CFLAGS)"

include ../../gar.mk

DRI_DIRS := $(strip \
	$(if $(filter i386  ,$(GARCH_FAMILY)),i810 i915 i965 nouveau r200 r300 r600 radeon savage sis swrast unichrome) \
	$(if $(filter x86_64,$(GARCH_FAMILY)),     i915 i965 nouveau r200 r300 r600 radeon savage sis swrast unichrome))
DRI_DIRS := `echo "$(DRI_DIRS)" | sed -e 's% %,%g'`

pre-configure:
	@$(call RUN_AUTOTOOLS)
	@$(MAKECOOKIE)

install-source:
	@mkdir -p $(DESTDIR)$(sourcedir)
	@rm -f $(DESTDIR)$(sourcedir)/Mesa
	@ln -sf $(PWD)/$(WORKSRC) $(DESTDIR)$(sourcedir)/Mesa
	@$(MAKECOOKIE)

install-cross:
	@mkdir -p $(DESTDIR)$(bindir)
	@cp -f $(WORKSRC)/src/glsl/builtin_compiler $(DESTDIR)$(bindir)/mesa-builtin_compiler
	@$(MAKECOOKIE)
