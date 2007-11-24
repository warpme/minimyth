GARNAME = nvidia
GARVERSION = $(word 1,$(VERSION_LIST))
CATEGORIES = nvidia
MASTER_SITES = http://us.download.nvidia.com/XFree86/Linux-$(SUPER_VERSION)/$(GARVERSION)/
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
MAJOR_VERSION = 71
MINOR_VERSION = 86
TEENY_VERSION = 01
EXTRA_VERSION = $(strip \
	$(if $(filter x86,   $(SUPER_VERSION)),pkg1) \
	$(if $(filter x86_64,$(SUPER_VERSION)),pkg2))
	
FILE_LIST_BIN     = $(strip \
		nvidia-bug-report.sh:/usr/bin:$(bindir) \
		nvidia-settings:/usr/bin:$(bindir) \
	)
FILE_LIST_LIB_DRV = $(strip \
		nvidia_drv.so:/usr/X11R6/lib/modules/drivers:$(libdir)/nvidia/xorg/modules/drivers \
	)
FILE_LIST_LIB_A   = $(strip \
		libXvMCNVIDIA.a:/usr/X11R6/lib:$(libdir)/nvidia \
	)
FILE_LIST_LIB_SO  = $(strip \
		libGL.so:/usr/lib:$(libdir)/nvidia \
		libGLcore.so:/usr/lib:$(libdir)/nvidia \
		libnvidia-tls.so:/usr/lib/tls:$(libdir)/nvidia \
		libXvMCNVIDIA.so:/usr/X11R6/lib:$(libdir)/nvidia \
		libglx.so:/usr/X11R6/lib/modules/extensions:$(libdir)/nvidia/xorg/modules/extensions \
	)
VERSION_LIST  = $(strip \
	$(if $(MAJOR_VERSION), \
		$(if $(MINOR_VERSION), \
			$(if $(TEENY_VERSION), \
				$(MAJOR_VERSION).$(MINOR_VERSION).$(TEENY_VERSION) \
			) \
			$(MAJOR_VERSION).$(MINOR_VERSION) \
		) \
		$(MAJOR_VERSION) \
	))

DISTFILE      = NVIDIA-Linux-$(SUPER_VERSION)-$(GARVERSION)-$(EXTRA_VERSION)

WORKSRC = $(WORKDIR)/$(DISTFILE)

BUILD_SCRIPTS   = $(WORKSRC)/usr/src/nv/makefile
INSTALL_SCRIPTS = kernel x11

BUILD_ARGS = \
	module \
	$(LINUX_MAKE_ARGS) \
	HOST_CC=$(build_CC) \
	SYSSRC=$(shell readlink -f $(DESTDIR)$(LINUX_SOURCEDIR)) \
	SYSOUT=$(shell readlink -f $(DESTDIR)$(LINUX_BUILDDIR)) \
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
	@$(foreach entry,$(FILE_LIST_BIN), \
		install -D \
		    $(WORKSRC)$(word 2,$(subst :, ,$(entry)))/$(word 1,$(subst :, ,$(entry))) \
		    $(DESTDIR)$(word 3,$(subst :, ,$(entry)))/$(word 1,$(subst :, ,$(entry))) ; \
	)
	@rm -rf $(DESTDIR)$(libdir)/nvidia
	@$(foreach entry,$(FILE_LIST_LIB_DRV), \
		install -D \
		    $(WORKSRC)$(word 2,$(subst :, ,$(entry)))/$(word 1,$(subst :, ,$(entry))) \
		    $(DESTDIR)$(word 3,$(subst :, ,$(entry)))/$(word 1,$(subst :, ,$(entry))) ; \
	)
	@$(foreach entry,$(FILE_LIST_LIB_A), \
		install -D \
		    $(WORKSRC)$(word 2,$(subst :, ,$(entry)))/$(word 1,$(subst :, ,$(entry))) \
		    $(DESTDIR)$(word 3,$(subst :, ,$(entry)))/$(word 1,$(subst :, ,$(entry))) ; \
	)
	@$(foreach entry,$(FILE_LIST_LIB_SO), \
		install -D \
		    $(WORKSRC)$(word 2,$(subst :, ,$(entry)))/$(word 1,$(subst :, ,$(entry))).$(word 1,$(VERSION_LIST)) \
		    $(DESTDIR)$(word 3,$(subst :, ,$(entry)))/$(word 1,$(subst :, ,$(entry))).$(word 1,$(VERSION_LIST)) ; \
	)
	@$(foreach entry,$(FILE_LIST_LIB_SO), $(if $(word 2,$(VERSION_LIST)), \
		ln -sf \
		    $(word 1,$(subst :, ,$(entry))).$(word 1,$(VERSION_LIST)) \
		    $(DESTDIR)$(word 3,$(subst :, ,$(entry)))/$(word 1,$(subst :, ,$(entry))).$(word 2,$(VERSION_LIST)) ; \
	))
	@$(foreach entry,$(FILE_LIST_LIB_SO), $(if $(word 3,$(VERSION_LIST)), \
		ln -sf \
		    $(word 1,$(subst :, ,$(entry))).$(word 2,$(VERSION_LIST)) \
		    $(DESTDIR)$(word 3,$(subst :, ,$(entry)))/$(word 1,$(subst :, ,$(entry))).$(word 3,$(VERSION_LIST)) ; \
	))
	@$(foreach entry,$(FILE_LIST_LIB_SO), \
		ln -sf \
		    $(word 1,$(subst :, ,$(entry))).$(word $(words $(VERSION_LIST)),$(VERSION_LIST)) \
		    $(DESTDIR)$(word 3,$(subst :, ,$(entry)))/$(word 1,$(subst :, ,$(entry))) ; \
	)
	@$(foreach entry,$(FILE_LIST_LIB_SO), \
		ln -sf \
		    $(word 1,$(subst :, ,$(entry))).$(word $(words $(VERSION_LIST)),$(VERSION_LIST)) \
		    $(DESTDIR)$(word 3,$(subst :, ,$(entry)))/$(word 1,$(subst :, ,$(entry))).1 ; \
	)
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
