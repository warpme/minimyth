GARNAME = nvidia
GARVERSION = $(MAJOR_VERSION).$(MINOR_VERSION)-$(TEENY_VERSION)
CATEGORIES = nvidia
MASTER_SITES = http://download.nvidia.com/XFree86/Linux-$(SUPER_VERSION)/$(GARVERSION)/
DISTFILES = $(DISTFILE).run
LICENSE = nvidia
nvidia_LICENSE_TEXT=$(WORKSRC)/LICENSE

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c kernel/kernel xorg/xorg
BUILDDEPS = utils/module-init-tools

SUPER_VERSION = $(strip \
	$(if $(filter i386,  $(GARCH_FAMILY)),x86   ) \
	$(if $(filter x86_64,$(GARCH_FAMILY)),x86_64))
MAJOR_VERSION = 1
MINOR_VERSION = 0
TEENY_VERSION = 7185
EXTRA_VERSION = $(strip \
	$(if $(filter x86,   $(SUPER_VERSION)),pkg1) \
	$(if $(filter x86_64,$(SUPER_VERSION)),pkg2))
DISTFILE      = NVIDIA-Linux-$(SUPER_VERSION)-$(GARVERSION)-$(EXTRA_VERSION)

WORKSRC = $(WORKDIR)/$(DISTFILE)

BUILD_SCRIPTS   = $(WORKSRC)/usr/src/nv/makefile
INSTALL_SCRIPTS = kernel x11

BUILD_ARGS = \
	module \
	$(LINUX_MAKE_ARGS) \
	HOST_CC=$(build_CC) \
	SYSSRC=$(DESTDIR)$(LINUX_SOURCEDIR) \
	SYSOUT=$(DESTDIR)$(LINUX_BUILDDIR) \
	MODULE_ROOT=$(DESTDIR)$(LINUX_MODULESDIR)/misc/nvidia

BUILD_ENV = \
	$(LINUX_MAKE_ENV)

GAR_EXTRA_CONF += kernel-$(mm_KERNEL_VERSION)/linux/package-api.mk
include ../../gar.mk

extract-%.run:
	@mkdir -p $(WORKDIR)
	@cp $(DOWNLOADDIR)/$*.run $(WORKDIR)
	@cd $(WORKDIR) ; sh $*.run --extract-only
	@cd $(WORKDIR) ; rm -rf $*.run
	@$(MAKECOOKIE)

build-%/makefile:
	@echo " ==> Running make in $*"
	@cd $*; $(BUILD_ENV) $(MAKE) $(PARALLELMFLAGS) $(foreach TTT,$(BUILD_OVERRIDE_DIRS),$(TTT)="$($(TTT))") $(BUILD_ARGS)
	@$(MAKECOOKIE)

install-kernel:
	@mkdir -p $(DESTDIR)$(LINUX_MODULESDIR)/misc/nvidia
	@cp $(WORKSRC)/usr/src/nv/nvidia.ko $(DESTDIR)$(LINUX_MODULESDIR)/misc/nvidia/nvidia.ko
	@depmod -b "$(DESTDIR)$(rootdir)" "$(LINUX_FULL_VERSION)"
	@$(MAKECOOKIE)

install-x11:
	@rm -rf $(DESTDIR)$(bindir)/nvidia*
	@mkdir -p $(DESTDIR)$(bindir)
	@install $(WORKSRC)/usr/bin/nvidia-bug-report.sh \
		$(DESTDIR)$(bindir)/nvidia-bug-report.sh
	@rm -rf $(DESTDIR)$(libdir)/nvidia
	@mkdir -p $(DESTDIR)$(libdir)/nvidia
	@mkdir -p $(DESTDIR)$(libdir)/nvidia/xorg/modules/drivers
	@mkdir -p $(DESTDIR)$(libdir)/nvidia/xorg/modules/extensions
	@install $(WORKSRC)/usr/X11R6/lib/libXvMCNVIDIA.a \
		$(DESTDIR)$(libdir)/nvidia/libXvMCNVIDIA.a
	@install $(WORKSRC)/usr/X11R6/lib/libXvMCNVIDIA.so.$(MAJOR_VERSION).$(MINOR_VERSION).$(TEENY_VERSION) \
		$(DESTDIR)$(libdir)/nvidia
	@install $(WORKSRC)/usr/lib/libGL.so.$(MAJOR_VERSION).$(MINOR_VERSION).$(TEENY_VERSION) \
		$(DESTDIR)$(libdir)/nvidia
	@install $(WORKSRC)/usr/lib/libGLcore.so.$(MAJOR_VERSION).$(MINOR_VERSION).$(TEENY_VERSION) \
		$(DESTDIR)$(libdir)/nvidia
	@install $(WORKSRC)/usr/X11R6/lib/modules/drivers/nvidia_drv.so \
		$(DESTDIR)$(libdir)/nvidia/xorg/modules/drivers
	@install $(WORKSRC)/usr/X11R6/lib/modules/extensions/libglx.so.$(MAJOR_VERSION).$(MINOR_VERSION).$(TEENY_VERSION) \
		$(DESTDIR)$(libdir)/nvidia/xorg/modules/extensions
	@install $(WORKSRC)/usr/lib/tls/libnvidia-tls.so.$(MAJOR_VERSION).$(MINOR_VERSION).$(TEENY_VERSION) \
		$(DESTDIR)$(libdir)/nvidia
	@cd $(DESTDIR)$(libdir)/nvidia ; \
		ln -sf libXvMCNVIDIA.so.$(MAJOR_VERSION).$(MINOR_VERSION).$(TEENY_VERSION) \
		       libXvMCNVIDIA.so.$(MAJOR_VERSION).$(MINOR_VERSION); \
		ln -sf libXvMCNVIDIA.so.$(MAJOR_VERSION).$(MINOR_VERSION) \
		       libXvMCNVIDIA.so.$(MAJOR_VERSION) ; \
		ln -sf libXvMCNVIDIA.so.$(MAJOR_VERSION) \
		       libXvMCNVIDIA.so
	@cd $(DESTDIR)$(libdir)/nvidia ; \
		ln -sf libGL.so.$(MAJOR_VERSION).$(MINOR_VERSION).$(TEENY_VERSION) \
		       libGL.so.$(MAJOR_VERSION).$(MINOR_VERSION); \
		ln -sf libGL.so.$(MAJOR_VERSION).$(MINOR_VERSION) \
		       libGL.so.$(MAJOR_VERSION) ; \
		ln -sf libGL.so.$(MAJOR_VERSION) \
		       libGL.so
	@cd $(DESTDIR)$(libdir)/nvidia ; \
		ln -sf libGLcore.so.$(MAJOR_VERSION).$(MINOR_VERSION).$(TEENY_VERSION) \
		       libGLcore.so.$(MAJOR_VERSION).$(MINOR_VERSION); \
		ln -sf libGLcore.so.$(MAJOR_VERSION).$(MINOR_VERSION) \
		       libGLcore.so.$(MAJOR_VERSION) ; \
		ln -sf libGLcore.so.$(MAJOR_VERSION) \
		       libGLcore.so
	@cd $(DESTDIR)$(libdir)/nvidia/xorg/modules/extensions; \
		ln -sf libglx.so.$(MAJOR_VERSION).$(MINOR_VERSION).$(TEENY_VERSION) \
		       libglx.so.$(MAJOR_VERSION).$(MINOR_VERSION); \
		ln -sf libglx.so.$(MAJOR_VERSION).$(MINOR_VERSION) \
		       libglx.so.$(MAJOR_VERSION) ; \
		ln -sf libglx.so.$(MAJOR_VERSION) \
		       libglx.so
	@cd $(DESTDIR)$(libdir)/nvidia ; \
		ln -sf libnvidia-tls.so.$(MAJOR_VERSION).$(MINOR_VERSION).$(TEENY_VERSION) \
		       libnvidia-tls.so.$(MAJOR_VERSION).$(MINOR_VERSION); \
		ln -sf libnvidia-tls.so.$(MAJOR_VERSION).$(MINOR_VERSION) \
		       libnvidia-tls.so.$(MAJOR_VERSION) ; \
		ln -sf libnvidia-tls.so.$(MAJOR_VERSION) \
		       libnvidia-tls.so
	@$(MAKECOOKIE)

clean-all: clean-all-kernel clean-all-x11
	@rm -rf $(DESTDIR)$(versiondir)/$(GARNAME)
	@rm -rf $(DESTDIR)$(licensedir)/$(GARNAME)
	@$(MAKE) clean

clean-all-kernel:
	@mkdir -p $(DESTDIR)$(LINUX_MODULESDIR)/misc/nvidia

clean-all-x11:
	@rm -rf $(DESTDIR)$(bindir)/nvidia*
	@rm -rf $(DESTDIR)$(libdir)/nvidia
