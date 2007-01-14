GARNAME = unionfs
GARVERSION = 1.3
CATEGORIES = kernel-2.6.17
MASTER_SITES  = ftp://ftp.fsl.cs.sunysb.edu/pub/$(GARNAME)/
MASTER_SITES += ftp://ftp.fsl.cs.sunysb.edu/pub/$(GARNAME)/snapshots/
MASTER_SITES += ftp://ftp.fsl.cs.sunysb.edu/pub/$(GARNAME)/snapshots/old/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-gar.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c kernel-2.6.17/linux utils/util-linux-ng

BUILD_SCRIPTS   = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = $(WORKSRC)/Makefile

DEFAULT_ARGS = \
	$(LINUX_MAKE_ARGS) \
	LINUXSRC="$(DESTDIR)$(LINUX_SOURCEDIR)" \
	SBINDIR="$(DESTDIR)$(sbindir)" \
	MANDIR="$(DESTDIR)$(mandir)" \
	MODPREFIX="$(DESTDIR)" \
	MODDIR="$(LINUX_MODULESDIR)" \
	UNIONFS_DEBUG_CFLAG="" \
	UNIONFS_OPT_CFLAG="" \
	EXTRACFLAGS="-DUNIONFS_NDEBUG" \
	CC="$(CC)" \
	LD="$(LD)" \
	LINUXVERSION="$(LINUX_MAJOR_VERSION).$(LINUX_MINOR_VERSION)"
BUILD_ARGS   = $(DEFAULT_ARGS)
INSTALL_ARGS = $(DEFAULT_ARGS)

BUILD_ENV   = $(LINUX_MAKE_ENV)
INSTALL_ENV = $(LINUX_MAKE_ENV)

GAR_EXTRA_CONF += kernel-2.6.17/linux/package-api.mk
include ../../gar.mk

pre-install:
	@rm -rf $(DESTDIR)$(LINUX_MODULESDIR)/kernel/fs/unionfs
	@$(MAKECOOKIE)

post-install:
	@depmod -b "$(DESTDIR)$(rootdir)" "$(LINUX_FULL_VERSION)"
	@$(MAKECOOKIE)
