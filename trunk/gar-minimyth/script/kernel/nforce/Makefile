GARNAME = nforce
GARVERSION = $(NFORCE_VERSION)
CATEGORIES = kernel
MASTER_SITES = http://download.nvidia.com/XFree86/nforce/$(GARVERSION)/
http://download.nvidia.com/XFree86/nforce/1.0-0310/NFORCE-Linux-x86_64-1.0-0310-pkg1.run
DISTFILES = $(NFORCE_DISTFILE).run
LICENSE = nforce
nforce_LICENSE_TEXT=$(WORKSRC)/LICENSE

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c kernel/linux
BUILDDEPS = kernel/module-init-tools

WORKSRC = $(WORKDIR)/$(NFORCE_DISTFILE)

BUILD_SCRIPTS   = $(WORKSRC)/nvnet/makefile $(WORKSRC)/nvsound/main/makefile
INSTALL_SCRIPTS = $(WORKSRC)/nvnet/makefile $(WORKSRC)/nvsound/main/makefile

BUILD_ARGS   = \
	$(KERNEL_MAKE_ARGS) \
	SYSSRC=$(DESTDIR)$(KERNEL_BUILDDIR) \
	INSTROOT=$(DESTDIR) \
	TARGETDIR=$(KERNEL_MODULESDIR)/misc/nforce
INSTALL_ARGS = \
	$(KERNEL_MAKE_ARGS) \
	SYSSRC=$(DESTDIR)$(KERNEL_BUILDDIR) \
	INSTROOT=$(DESTDIR) \
	TARGETDIR=$(KERNEL_MODULESDIR)/misc/nforce

BUILD_ENV   = \
	$(KERNEL_MAKE_ENV)
INSTALL_ENV = \
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

pre-install:
	@mkdir -p $(DESTDIR)$(KERNEL_MODULESDIR)/misc/nforce
	@$(MAKECOOKIE)

install-%/makefile:
	@echo " ==> Running make install in $*"
	@cd $*; $(INSTALL_ENV) $(MAKE) DESTDIR=$(DESTDIR) $(foreach TTT,$(INSTALL_OVERRIDE_DIRS),$(TTT)="$(DESTDIR)$($(TTT))") $(INSTALL_ARGS) install
	@$(MAKECOOKIE)

post-install:
	@depmod -b "$(DESTDIR)$(rootdir)" "$(KERNEL_FULL_VERSION)"
	@$(MAKECOOKIE)
