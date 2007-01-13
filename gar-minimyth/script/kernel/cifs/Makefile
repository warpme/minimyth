GARNAME = cifs
GARVERSION = 1.34a
CATEGORIES = kernel
MASTER_SITES = http://pserver.samba.org/samba/ftp/cifs-cvs/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-out_of_tree.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c kernel/linux

WORKSRC = $(WORKDIR)/$(DISTNAME)/fs/cifs
PATCHDIR = $(WORKDIR)/$(DISTNAME)

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
	cd $(WORKSRC) ; $(BUILD_ENV) make -C $(DESTDIR)$(KERNEL_SOURCEDIR) SUBDIRS=`pwd` modules $(BUILD_ARGS)
	$(MAKECOOKIE)

install-custom:
	@rm -rf $(DESTDIR)$(KERNEL_MODULESDIR)/misc/cifs
	@mkdir -p $(DESTDIR)$(KERNEL_MODULESDIR)/misc/cifs
	@cp $(WORKSRC)/cifs.ko $(DESTDIR)$(KERNEL_MODULESDIR)/misc/cifs/
	@depmod -b "$(DESTDIR)$(rootdir)" "$(KERNEL_FULL_VERSION)"
	@$(MAKECOOKIE)
