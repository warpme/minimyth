GARNAME = Mesa
GARVERSION = 8.0.2
CATEGORIES = $(CATEGORY)
MASTER_SITES  = ftp://ftp.freedesktop.org/pub/mesa/beta/
MASTER_SITES += ftp://ftp.freedesktop.org/pub/mesa/$(GARVERSION)/
DISTFILES = MesaLib-$(GARVERSION).tar.bz2
PATCHFILES  = \
	$(DISTNAME)-git_9b3ac17.patch
PATCHFILES += \
	$(DISTNAME)-llvm_so.patch \
	$(DISTNAME)-version.patch
ifneq ($(DESTIMG),build)
PATCHFILES += \
	$(DISTNAME)-cross.patch
endif
LICENSE = LGPL2/MIT

DESCRIPTION = 
define BLURB
endef

DEPENDS    = lang/c lang/cxx devel/llvm lib/expat X11/libvdpau \
	$(CATEGORY)/dri2proto \
	$(CATEGORY)/xextproto \
	$(CATEGORY)/glproto \
	$(CATEGORY)/libdrm \
	$(CATEGORY)/libX11 \
	$(CATEGORY)/libxcb \
	$(CATEGORY)/libXdamage \
	$(CATEGORY)/libXext \
	$(CATEGORY)/libXfixes \
	$(CATEGORY)/libXxf86vm \
	$(CATEGORY)/libXvMC
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

# There appears to be a circular dependency between Mesa and libva, so I have disabled libva support in Mesa.
CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes="$(DESTDIR)$(includedir)" \
	--x-libraries="$(DESTDIR)$(libdir)" \
	$(if $(filter i386  , $(GARCH_FAMILY)),--enable-32-bit) \
	$(if $(filter x86_64, $(GARCH_FAMILY)),--enable-64-bit) \
	--disable-static \
	--enable-shared \
	--disable-debug \
	--disable-mangling \
	--disable-texture-float \
	--enable-asm \
	--disable-selinux \
	--enable-opengl \
	--disable-gles1 \
	--disable-gles2 \
	--disable-openvg \
	--enable-dri \
	--enable-glx \
	--disable-osmesa \
	--disable-egl \
	--disable-xorg \
	--disable-xa \
	--disable-d3d1x \
	--disable-gbm \
	--enable-xvmc \
	--enable-vdpau \
	--disable-va  \
	--disable-xlib-glx \
	--disable-gallium-egl \
	--disable-gallium-gbm \
	--disable-shared-glapi \
	--enable-shared-dricore \
	--enable-gallium-llvm \
	--with-gallium-drivers="i915,nouveau,r300,r600,svga,swrast" \
	--with-x \
	--with-dri-driverdir="$(libdir)/xorg/modules/dri" \
	--with-dri-drivers="$(DRI_DIRS)" \
	--with-state-trackers="dri,glx"
BUILD_ARGS  = \
	HOST_CC="$(build_CC)" \
	HOST_CFLAGS="$(build_CFLAGS)"

include ../../gar.mk

xDRI_DIRS := $(strip \
	$(if $(filter i386  ,$(GARCH_FAMILY)),i915 i965 nouveau r200 r300 r600 radeon swrast) \
	$(if $(filter x86_64,$(GARCH_FAMILY)),i915 i965 nouveau r200 r300 r600 radeon swrast))
DRI_DIRS := $(strip \
	$(if $(filter i386  ,$(GARCH_FAMILY)),i965 r200 radeon) \
	$(if $(filter x86_64,$(GARCH_FAMILY)),i965 r200 radeon))
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
