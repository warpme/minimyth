GARNAME = nvidia
GARVERSION = $(NVIDIA_VERSION)
CATEGORIES = kernel
MASTER_SITES = http://download.nvidia.com/XFree86/Linux-$(NVIDIA_SUPER_VERSION)/$(GARVERSION)/
DISTFILES = $(NVIDIA_DISTFILE).run
PATCHFILES = $(NVIDIA_DISTFILE)-sa_interrupt.patch
LICENSE = nvidia
nvidia_LICENSE_TEXT=$(WORKSRC)/LICENSE

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c kernel/linux
BUILDDEPS = kernel/module-init-tools

WORKSRC = $(WORKDIR)/$(NVIDIA_DISTFILE)

BUILD_SCRIPTS   = $(WORKSRC)/usr/src/nv/makefile
INSTALL_SCRIPTS = custom

BUILD_ARGS   = \
	module \
	$(KERNEL_MAKE_ARGS) \
	HOST_CC=$(build_CC) \
	SYSSRC=$(DESTDIR)$(KERNEL_SOURCEDIR) \
	SYSOUT=$(DESTDIR)$(KERNEL_BUILDDIR) \
	MODULE_ROOT=$(DESTDIR)$(KERNEL_MODULESDIR)/misc/nvidia

BUILD_ENV   = \
	$(KERNEL_MAKE_ENV)

GAR_EXTRA_CONF += kernel/linux/package-api.mk
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

install-custom:
	@mkdir -p $(DESTDIR)$(KERNEL_MODULESDIR)/misc/nvidia
	@cp $(WORKSRC)/usr/src/nv/nvidia.ko $(DESTDIR)$(KERNEL_MODULESDIR)/misc/nvidia/nvidia.ko
	@depmod -b "$(DESTDIR)$(rootdir)" "$(KERNEL_FULL_VERSION)"
	@$(MAKECOOKIE)
