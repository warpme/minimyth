GARNAME = imon_vfd
GARVERSION = 20050317
CATEGORIES = kernel
MASTER_SITES =
DISTFILES = $(GARNAME).tgz
PATCHFILES = $(GARNAME)-module.patch $(GARNAME)-2.6.18.patch
#LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c kernel/linux

WORKSRC = $(WORKDIR)/imon

BUILD_SCRIPTS   = custom
INSTALL_SCRIPTS = custom

DEFAULT_ARGS = \
	$(KERNEL_MAKE_ARGS)
BUILD_ARGS   = $(DEFAULT_ARGS)
INSTALL_ARGS = $(DEFAULT_ARGS)

BUILD_ENV   = $(KERNEL_MAKE_ENV)
INSTALL_ENV = $(KERNEL_MAKE_ENV)

GAR_EXTRA_CONF += kernel/linux/package-api.mk
include ../../gar.mk

build-custom:
	@cd $(WORKSRC) ; $(BUILD_ENV) make -C $(DESTDIR)$(KERNEL_SOURCEDIR) SUBDIRS=`pwd` modules $(BUILD_ARGS)
	@$(MAKECOOKIE)

install-custom:
	@rm -rf $(DESTDIR)$(KERNEL_MODULESDIR)/misc/$(GARNAME)
	@mkdir -p $(DESTDIR)$(KERNEL_MODULESDIR)/misc/$(GARNAME)
	@cp $(WORKSRC)/$(GARNAME).ko $(DESTDIR)$(KERNEL_MODULESDIR)/misc/$(GARNAME)
	@depmod -b "$(DESTDIR)$(rootdir)" "$(KERNEL_FULL_VERSION)"
	@$(MAKECOOKIE)
