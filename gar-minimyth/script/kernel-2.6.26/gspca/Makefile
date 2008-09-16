GARNAME = gspcav1
GARVERSION = 20071224
CATEGORIES = kernel-2.6.26
MASTER_SITES  = http://mxhaard.free.fr/spca50x/Download/
MASTER_SITES += http://mxhaard.free.fr/spca50x/Download/oldrelease/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME).patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c kernel-2.6.26/linux

BUILD_SCRIPTS   = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = $(WORKSRC)/Makefile

DEFAULT_ARGS = \
	$(LINUX_MAKE_ARGS) \
	KERNEL_VERSION="$(LINUX_VERSION)" \
	KERNELDIR="$(DESTDIR)$(LINUX_BUILDDIR)" \
	MODULE_INSTALLDIR="$(DESTDIR)$(LINUX_MODULESDIR)/misc/gspca/" \
	MODULE_INSTALLDIR2="$(DESTDIR)$(LINUX_MODULESDIR)/misc/gspca/"
BUILD_ARGS   = $(DEFAULT_ARGS)
INSTALL_ARGS = $(DEFAULT_ARGS)

DEFAULT_ENV = \
	$(LINUX_MAKE_ENV)
BUILD_ENV   = $(DEFAULT_ENV)
INSTALL_ENV = $(DEFAULT_ENV)

GAR_EXTRA_CONF += kernel-2.6.26/linux/package-api.mk
include ../../gar.mk

post-install:
	depmod -b "$(DESTDIR)$(rootdir)" "$(LINUX_FULL_VERSION)"
	$(MAKECOOKIE)

clean-all:
	@$(MAKE) clean
	@rm -rf $(DESTDIR)$(LINUX_MODULESDIR)/misc/gspca
