GARNAME = uvc
GARVERSION = 252
CATEGORIES = kernel-2.6.26
MASTER_SITES = svn://svn.berlios.de/linux-uvc/linux-uvc/trunk/
DISTFILES = $(DISTNAME).tar.bz2
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
	KERNEL_DIR="$(DESTDIR)$(LINUX_BUILDDIR)" \
	INSTALL_MOD_DIR="misc/uvc" \
	INSTALL_MOD_PATH="$(DESTDIR)"
BUILD_ARGS   = $(DEFAULT_ARGS)
INSTALL_ARGS = $(DEFAULT_ARGS)

DEFAULT_ENV = \
	$(LINUX_MAKE_ENV)
BUILD_ENV   = $(DEFAULT_ENV)
INSTALL_ENV = $(DEFAULT_ENV)

GAR_EXTRA_CONF += kernel-2.6.26/linux/package-api.mk
include ../../gar.mk

svn//%/$(DISTNAME).tar.bz2:
	@$(call FETCH_SVN, svn://$*, $(GARVERSION), $(DISTNAME))
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

post-install:
	@depmod -b "$(DESTDIR)$(rootdir)" "$(LINUX_FULL_VERSION)"
	@$(MAKECOOKIE)

clean-all:
	@$(MAKE) clean
	@rm -rf $(DESTDIR)$(LINUX_MODULESDIR)/misc/$(GARNAME)
