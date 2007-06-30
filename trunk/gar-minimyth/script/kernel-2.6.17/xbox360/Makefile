GARNAME = xbox360
GARVERSION =
CATEGORIES = kernel-2.6.17
MASTER_SITES =
DISTFILES = Makefile xbox360.c
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

extract-xbox360.c:
	@mkdir -p $(WORKSRC)
	@cp $(DOWNLOADDIR)/xbox360.c $(WORKSRC)/
	@$(MAKECOOKIE)

build-custom:
	@cd $(WORKSRC) ; $(BUILD_ENV) $(MAKE) $(PARALLELMFLAGS) -C $(DESTDIR)$(LINUX_SOURCEDIR) SUBDIRS=`pwd` modules $(BUILD_ARGS)
	@$(MAKECOOKIE)

install-custom:
	@rm -f $(DESTDIR)$(LINUX_MODULESDIR)/kernel/drivers/usb/input/xbox360.*
	@mkdir -p $(DESTDIR)$(LINUX_MODULESDIR)/kernel/drivers/usb/input
	@cp $(WORKSRC)/xbox360.ko $(DESTDIR)$(LINUX_MODULESDIR)/kernel/drivers/usb/input/
	@depmod -b "$(DESTDIR)$(rootdir)" "$(LINUX_FULL_VERSION)"
	@$(MAKECOOKIE)
