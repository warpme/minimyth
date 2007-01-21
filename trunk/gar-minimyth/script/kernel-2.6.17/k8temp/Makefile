GARNAME = k8temp
GARVERSION =
CATEGORIES = kernel-2.6.17
MASTER_SITES =
DISTFILES = Makefile k8temp.c
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c kernel-2.6.17/linux

BUILD_SCRIPTS   = custom
INSTALL_SCRIPTS = custom

DEFAULT_ARGS = \
	$(LINUX_MAKE_ARGS)
BUILD_ARGS   = $(DEFAULT_ARGS)
INSTALL_ARGS = $(DEFAULT_ARGS)

BUILD_ENV   = $(LINUX_MAKE_ENV)
INSTALL_ENV = $(LINUX_MAKE_ENV)

GAR_EXTRA_CONF += kernel-2.6.17/linux/package-api.mk
include ../../gar.mk

extract-Makefile:
	@mkdir -p $(WORKSRC)
	@cp $(DOWNLOADDIR)/Makefile $(WORKSRC)/
	@$(MAKECOOKIE)

extract-k8temp.c:
	@mkdir -p $(WORKSRC)
	@cp $(DOWNLOADDIR)/k8temp.c $(WORKSRC)/
	@$(MAKECOOKIE)

build-custom:
	@cd $(WORKSRC) ; $(BUILD_ENV) make -C $(DESTDIR)$(LINUX_SOURCEDIR) SUBDIRS=`pwd` modules $(BUILD_ARGS)
	@$(MAKECOOKIE)

install-custom:
	@rm -f $(DESTDIR)$(LINUX_MODULESDIR)/kernel/drivers/hwmon/k8temp.*
	@mkdir -p $(DESTDIR)$(LINUX_MODULESDIR)/kernel/drivers/hwmon
	@cp $(WORKSRC)/k8temp.ko $(DESTDIR)$(LINUX_MODULESDIR)/kernel/drivers/hwmon/
	@depmod -b "$(DESTDIR)$(rootdir)" "$(LINUX_FULL_VERSION)"
	@$(MAKECOOKIE)
