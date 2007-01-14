GARNAME = drm
GARVERSION = d51e1bb56ca2f7858cdeac6f61a7b747c1e15b1e
CATEGORIES = kernel
MASTER_SITES = git://anongit.freedesktop.org/git/mesa/drm/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = MIT

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c kernel/linux
BUILDDEPS = kernel/module-init-tools

WORKSRC = $(WORKDIR)/$(DISTNAME)/linux-core

DRM_MODULES = i810 i830 i915 via

BUILD_SCRIPTS   = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = custom

BUILD_ARGS = $(KERNEL_MAKE_ARGS) LINUXDIR="$(DESTDIR)$(KERNEL_SOURCEDIR)" DRM_MODULES="$(DRM_MODULES)"

BUILD_ENV = $(KERNEL_MAKE_ENV)

GAR_EXTRA_CONF += kernel/linux/package-api.mk
include ../../gar.mk

git//%$(DISTNAME).tar.bz2:
	@$(call FETCH_GIT, $*, $(GARVERSION), $(DISTNAME))
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

install-custom:
	@mkdir -p "$(DESTDIR)$(KERNEL_MODULESDIR)/misc/drm/"
	@cp $(WORKSRC)/*.ko "$(DESTDIR)$(KERNEL_MODULESDIR)/misc/drm/"
	@depmod -b "$(DESTDIR)$(rootdir)" "$(KERNEL_FULL_VERSION)"
	@$(MAKECOOKIE)

clean-all:
	@$(MAKE) clean
	@rm -rf "$(DESTDIR)$(KERNEL_MODULESDIR)/misc/drm/"
