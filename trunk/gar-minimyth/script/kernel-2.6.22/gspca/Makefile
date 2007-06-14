GARNAME = gspcav1
GARVERSION = 20070508
CATEGORIES = kernel-2.6.22
MASTER_SITES  = http://mxhaard.free.fr/spca50x/Download/
MASTER_SITES += http://mxhaard.free.fr/spca50x/Download/oldrelease/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME).patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c kernel-2.6.22/linux

BUILD_SCRIPTS   = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = $(WORKSRC)/Makefile

DEFAULT_ARGS = \
	$(LINUX_MAKE_ARGS) \
	KERNEL_VERSION="$(LINUX_VERSION)" \
	KERNELDIR="$(DESTDIR)$(LINUX_BUILDDIR)" \
	MODULE_INSTALLDIR="$(DESTDIR)$(LINUX_MODULESDIR)/kernel/drivers/usb/media/" \
	MODULE_INSTALLDIR2="$(DESTDIR)$(LINUX_MODULESDIR)/kernel/drivers/media/video/"
BUILD_ARGS   = $(DEFAULT_ARGS)
INSTALL_ARGS = $(DEFAULT_ARGS)

DEFAULT_ENV = \
	$(LINUX_MAKE_ENV)
BUILD_ENV   = $(DEFAULT_ENV)
INSTALL_ENV = $(DEFAULT_ENV)

GAR_EXTRA_CONF += kernel-2.6.22/linux/package-api.mk
include ../../gar.mk

post-install:
	depmod -b "$(DESTDIR)$(rootdir)" "$(LINUX_FULL_VERSION)"
	$(MAKECOOKIE)
