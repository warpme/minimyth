GARNAME = Mesa
GARVERSION = 7.4.3
CATEGORIES = $(CATEGORY)
MASTER_SITES  = http://www.mesa3d.org/beta/
MASTER_SITES += http://easynews.dl.sourceforge.net/sourceforge/mesa3d/
DISTFILES = MesaLib-$(GARVERSION).tar.gz MesaGLUT-$(GARVERSION).tar.gz MesaDemos-$(GARVERSION).tar.gz
PATCHFILES  = $(DISTNAME)-pkg_config.patch $(DISTNAME)-gen_matypes.patch $(DISTNAME).patch.gar
PATCHFILES += $(DISTNAME)-version.patch
LICENSE = LGPL2/MIT

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c++ lib/expat \
	$(CATEGORY)/dri2proto \
	$(CATEGORY)/xf86driproto \
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

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile xdemos source

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes="$(DESTDIR)$(includedir)" \
	--x-libraries="$(DESTDIR)$(libdir)" \
	--enable-shared \
	--disable-static \
	--with-driver="dri" \
	--with-x \
	--with-dri-driverdir="$(libdir)/xorg/modules/dri" \
	--with-dri-drivers="$(DRI_DIRS)"

BUILD_ARGS = \
	BUILD_CC="$(build_CC)" \
	BUILD_CFLAGS="$(build_CFLAGS)"

include ../../gar.mk

DRI_DIRS := $(strip \
	$(if $(filter i386  ,$(GARCH_FAMILY)),i810 i915 i965 r200 r300 radeon savage sis swrast unichrome) \
	$(if $(filter x86_64,$(GARCH_FAMILY)),     i915 i965 r200 r300 radeon savage sis swrast unichrome))
DRI_DIRS := `echo "$(DRI_DIRS)" | sed -e 's% %,%g'`

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(MAKECOOKIE)

install-xdemos:
	@mkdir -p $(DESTDIR)$(bindir)
	@cp -f $(WORKSRC)/progs/xdemos/glxgears $(DESTDIR)$(bindir)
	@cp -f $(WORKSRC)/progs/xdemos/glxinfo  $(DESTDIR)$(bindir)
	@$(MAKECOOKIE)

install-source:
	@mkdir -p $(DESTDIR)$(sourcedir)
	@rm -f $(DESTDIR)$(sourcedir)/Mesa
	@ln -sf $(PWD)/$(WORKSRC) $(DESTDIR)$(sourcedir)/Mesa
	@$(MAKECOOKIE)
