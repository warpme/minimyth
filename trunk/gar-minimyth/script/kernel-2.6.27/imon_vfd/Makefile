GARNAME = imon_vfd
GARVERSION = 20050317
CATEGORIES = kernel-2.6.27
MASTER_SITES =
DISTFILES = $(GARNAME).tgz
PATCHFILES = $(GARNAME)-module.patch $(GARNAME)-2.6.18.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c kernel-2.6.27/linux

WORKSRC = $(WORKDIR)/imon

BUILD_SCRIPTS   = custom
INSTALL_SCRIPTS = custom

DEFAULT_ARGS = \
	$(LINUX_MAKE_ARGS)
BUILD_ARGS   = $(DEFAULT_ARGS)
INSTALL_ARGS = $(DEFAULT_ARGS)

BUILD_ENV   = $(LINUX_MAKE_ENV)
INSTALL_ENV = $(LINUX_MAKE_ENV)

GAR_EXTRA_CONF += kernel-2.6.27/linux/package-api.mk
include ../../gar.mk

build-custom:
	@cd $(WORKSRC) ; $(BUILD_ENV) $(MAKE) $(PARALLELMFLAGS) -C $(DESTDIR)$(LINUX_SOURCEDIR) SUBDIRS=`pwd` modules $(BUILD_ARGS)
	@$(MAKECOOKIE)

install-custom:
	@rm -rf $(DESTDIR)$(LINUX_MODULESDIR)/misc/$(GARNAME)
	@mkdir -p $(DESTDIR)$(LINUX_MODULESDIR)/misc/$(GARNAME)
	@cp $(WORKSRC)/$(GARNAME).ko $(DESTDIR)$(LINUX_MODULESDIR)/misc/$(GARNAME)
	@depmod -b "$(DESTDIR)$(rootdir)" "$(LINUX_FULL_VERSION)"
	@$(MAKECOOKIE)

clean-all:
	@$(MAKE) clean
	@rm -rf $(DESTDIR)$(LINUX_MODULESDIR)/misc/$(GARNAME)
