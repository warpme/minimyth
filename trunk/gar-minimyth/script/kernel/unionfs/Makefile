GARNAME = unionfs
GARVERSION = 1.0.12a
CATEGORIES = kernel
MASTER_SITES  = ftp://ftp.fsl.cs.sunysb.edu/pub/$(GARNAME)/
MASTER_SITES += ftp://ftp.fsl.cs.sunysb.edu/pub/$(GARNAME)/snapshots/
MASTER_SITES += ftp://ftp.fsl.cs.sunysb.edu/pub/$(GARNAME)/snapshots/old/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-gar.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c kernel/linux

BUILD_SCRIPTS   = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = $(WORKSRC)/Makefile

DEFAULT_ARGS = \
	$(KERNEL_MAKE_ARGS) \
	LINUXSRC="$(DESTDIR)$(KERNEL_SOURCEDIR)" \
	SBINDIR="$(DESTDIR)$(sbinddir)" \
	MANDIR="$(DESTDIR)$(mandir)" \
	MODPREFIX="$(DESTDIR)" \
	MODDIR="$(KERNEL_MODULESDIR)/misc/unionfs" \
	UNIONFS_DEBUG_CFLAG="" \
	UNIONFS_OPT_CFLAG="$(CFLAGS)" \
	EXTRACFLAGS="-DNODEBUG" \
	CC="$(CC)" \
	KERNELVERSION="$(KERNEL_MAJOR_VERSION).$(KERNEL_MINOR_VERSION)"
BUILD_ARGS   = $(DEFAULT_ARGS)
INSTALL_ARGS = $(DEFAULT_ARGS)

BUILD_ENV   = $(KERNEL_MAKE_ENV)
INSTALL_ENV = $(KERNEL_MAKE_ENV)

GAR_EXTRA_CONF += kernel/linux/package-api.mk
include ../../gar.mk

pre-install:
	@rm -rf $(DESTDIR)$(KERNEL_MODULESDIR)/misc/unionfs
	@mkdir -p $(DESTDIR)$(KERNEL_MODULESDIR)/misc/unionfs
	@$(MAKECOOKIE)

post-install:
	@depmod -b "$(DESTDIR)$(rootdir)" "$(KERNEL_FULL_VERSION)"
	@$(MAKECOOKIE)
