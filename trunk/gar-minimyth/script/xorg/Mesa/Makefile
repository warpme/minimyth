GARNAME = mesa
GARVERSION = 10.6.2
CATEGORIES = $(CATEGORY)
MASTER_SITES  = ftp://ftp.freedesktop.org/pub/mesa/$(GARVERSION)/
MASTER_SITES += ftp://ftp.freedesktop.org/pub/mesa/older-versions/10.x/$(GARVERSION)/
DISTFILES = $(DISTNAME).tar.xz
LICENSE = LGPL2/MIT

DESCRIPTION = 
define BLURB
endef

DEPENDS    = lang/c lang/cxx devel/libelf devel/llvm lib/expat X11/libva-mini X11/libvdpau \
	$(CATEGORY)/dri2proto \
	$(CATEGORY)/dri3proto \
	$(CATEGORY)/xextproto \
	$(CATEGORY)/glproto \
	$(CATEGORY)/libdrm \
	$(CATEGORY)/libX11 \
	$(CATEGORY)/libxcb \
	$(CATEGORY)/libXdamage \
	$(CATEGORY)/libXext \
	$(CATEGORY)/libXfixes \
	$(CATEGORY)/libxshmfence \
	$(CATEGORY)/libXxf86vm \
	$(CATEGORY)/libXvMC
ifneq ($(DESTIMG),build)
DEPENDS   += system/udev
endif
BUILDDEPS  = lib/libxml2 python/python \
	$(CATEGORY)/makedepend

PWD := $(shell pwd)
CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile source

CONFIGURE_ARGS  = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-silent-rules \
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
	--enable-dri \
	--enable-dri3 \
	--enable-glx \
	--disable-osmesa \
	--disable-gallium-osmesa \
	--enable-egl \
	--disable-xa \
	--enable-gbm \
	--disable-nine \
	--enable-xvmc \
	--enable-vdpau \
	--disable-omx \
	--enable-va \
	--disable-opencl \
	--disable-opencl-icd \
	--disable-xlib-glx \
	--enable-r600-llvm-compiler \
	--disable-gallium-tests \
	--enable-shared-glapi \
	--enable-driglx-direct \
	--disable-glx-tls \
	--enable-gallium-llvm \
	--enable-llvm-shared-libs \
	--with-gnu-ld \
	--with-gallium-drivers="i915,nouveau,r300,r600,radeonsi,svga,swrast" \
	--with-dri-driverdir="$(libdir)/dri" \
	--with-dri-drivers="i915,i965,nouveau,r200,radeon,swrast" \
	--with-egl-platforms="drm" \
	--with-xvmc-libdir="$(libdir)" \
	--with-vdpau-libdir="$(libdir)/vdpau" \
	--with-va-libdir="$(libdir)/dri"
ifeq ($(DESTIMG),build)
CONFIGURE_ARGS += \
	--enable-sysfs
endif

include ../../gar.mk

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

install-source:
	@mkdir -p $(DESTDIR)$(sourcedir)
	@rm -f $(DESTDIR)$(sourcedir)/Mesa
	@ln -sf $(PWD)/$(WORKSRC) $(DESTDIR)$(sourcedir)/Mesa
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/dri/gallium_drv_video.la
	@rm -f $(DESTDIR)$(libdir)/libEGL.la
	@rm -f $(DESTDIR)$(libdir)/libgbm.la
	@rm -f $(DESTDIR)$(libdir)/libGL.la
	@rm -f $(DESTDIR)$(libdir)/libglapi.la
	@$(MAKECOOKIE)
