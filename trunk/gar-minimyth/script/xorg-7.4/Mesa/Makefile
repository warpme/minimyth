GARNAME = Mesa
GARVERSION = 7.7.1
CATEGORIES = $(CATEGORY)
MASTER_SITES  = http://www.mesa3d.org/beta/
MASTER_SITES += ftp://ftp.freedesktop.org/pub/mesa/$(GARVERSION)/
MASTER_SITES += http://easynews.dl.sourceforge.net/sourceforge/mesa3d/
DISTFILES = MesaLib-$(GARVERSION).tar.bz2
PATCHFILES  = $(DISTNAME)-pkg_config.patch $(DISTNAME).patch.gar
PATCHFILES += $(DISTNAME)-version.patch
LICENSE = LGPL2/MIT

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c lang/cxx lib/expat \
	$(CATEGORY)/dri2proto \
	$(CATEGORY)/xf86driproto \
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
	$(CATEGORY)/xf86vidmodeproto \
	$(CATEGORY)/xproto
BUILDDEPS = $(CATEGORY)/makedepend

PWD := $(shell pwd)
CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile source

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes="$(DESTDIR)$(includedir)" \
	--x-libraries="$(DESTDIR)$(libdir)" \
	--enable-shared \
	--disable-static \
	--enable-xcb \
	--disable-gallium \
	--disable-gallium-svga \
	--disable-gallium-intel \
	--disable-gallium-radeon \
	--disable-gallium-nouveau \
	--with-driver="dri" \
	--with-x \
	--with-dri-driverdir="$(libdir)/xorg/modules/dri" \
	--with-dri-drivers="$(DRI_DIRS)"

BUILD_ARGS = \
	HOST_CC="$(build_CC)" \
	HOST_CFLAGS="$(build_CFLAGS)"

include ../../gar.mk

# Mesa 7.7.1 fails to compile with march=atom so replace with march=i686 or march=x86-64.
CFLAGS   := $(if $(filter -march=atom, $(CFLAGS)), \
                 $(if $(filter -m32, $(CFLAGS)), $(filter-out -march=atom, $(CFLAGS)) -march=i686) \
                 $(if $(filter -m64, $(CFLAGS)), $(filter-out -march=atom, $(CFLAGS)) -march=x86-64), \
                 $(CFLAGS))
CXXFLAGS := $(if $(filter -march=atom, $(CXXFLAGS)), \
                 $(if $(filter -m32, $(CXXFLAGS)), $(filter-out -march=atom, $(CXXFLAGS)) -march=i686) \
                 $(if $(filter -m64, $(CXXFLAGS)), $(filter-out -march=atom, $(CXXFLAGS)) -march=x86-64), \
                 $(CXXFLAGS))

# Fails to compile using GCC's linker plugin due to segmentation fault.
CFLAGS   := $(filter-out -fuse-linker-plugin, $(CFLAGS))
CXXFLAGS := $(filter-out -fuse-linker-plugin, $(CXXFLAGS))
LDFLAGS  := $(filter-out -fuse-linker-plugin, $(LDFLAGS))

DRI_DIRS := $(strip \
	$(if $(filter i386  ,$(GARCH_FAMILY)),i810 i915 i965 r200 r300 r600 radeon savage sis swrast unichrome) \
	$(if $(filter x86_64,$(GARCH_FAMILY)),     i915 i965 r200 r300 r600 radeon savage sis swrast unichrome))
DRI_DIRS := `echo "$(DRI_DIRS)" | sed -e 's% %,%g'`

pre-configure:
	@$(call RUN_AUTOTOOLS)
	@$(MAKECOOKIE)

install-source:
	@mkdir -p $(DESTDIR)$(sourcedir)
	@rm -f $(DESTDIR)$(sourcedir)/Mesa
	@ln -sf $(PWD)/$(WORKSRC) $(DESTDIR)$(sourcedir)/Mesa
	@$(MAKECOOKIE)
