GARNAME = vt1211
GARVERSION =
CATEGORIES = kernel
MASTER_SITES =
DISTFILES = Makefile vt1211.c
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c kernel/linux

BUILD_SCRIPTS   = custom
INSTALL_SCRIPTS = custom

DEFAULT_ARGS = \
	$(KERNEL_MAKE_ARGS) \
	LINUXSRC="$(DESTDIR)$(KERNEL_SOURCEDIR)" \
	SBINDIR="$(DESTDIR)$(sbinddir)" \
	MANDIR="$(DESTDIR)$(mandir)" \
	MODPREFIX="$(DESTDIR)" \
	MODDIR="$(KERNEL_MODULESDIR)/misc/unionfs" \
	UNIONFS_OPT_CFLAG="$(CFLAGS)" \
	CC="$(CC)" \
	KERNELVERSION="$(KERNEL_MAJOR_VERSION).$(KERNEL_MINOR_VERSION)"
BUILD_ARGS   = $(DEFAULT_ARGS)
INSTALL_ARGS = $(DEFAULT_ARGS)

BUILD_ENV   = $(KERNEL_MAKE_ENV)
INSTALL_ENV = $(KERNEL_MAKE_ENV)

GAR_EXTRA_CONF += kernel/linux/package-api.mk
include ../../gar.mk

extract-Makefile:
	@mkdir -p $(WORKSRC)
	@cp $(DOWNLOADDIR)/Makefile $(WORKSRC)/
	@$(MAKECOOKIE)

extract-vt1211.c:
	@mkdir -p $(WORKSRC)
	@cp $(DOWNLOADDIR)/vt1211.c $(WORKSRC)/
	@$(MAKECOOKIE)

build-custom:
	@cd $(WORKSRC) ; $(BUILD_ENV) make -C $(DESTDIR)$(KERNEL_SOURCEDIR) SUBDIRS=`pwd` modules $(BUILD_ARGS)
	@$(MAKECOOKIE)

install-custom:
	@rm -rf $(DESTDIR)$(KERNEL_MODULESDIR)/misc/vt1211
	@mkdir -p $(DESTDIR)$(KERNEL_MODULESDIR)/misc/vt1211
	@cp $(WORKSRC)/vt1211.ko $(DESTDIR)$(KERNEL_MODULESDIR)/misc/vt1211/
	@depmod -b "$(DESTDIR)$(rootdir)" "$(KERNEL_FULL_VERSION)"
	@$(MAKECOOKIE)
