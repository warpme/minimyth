GARNAME = drm
GARVERSION = 7766378d97323de375687285f2e125008b79045d
CATEGORIES = kernel-2.6.17
MASTER_SITES = git://anongit.freedesktop.org/git/mesa/drm/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = MIT

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c kernel-2.6.17/linux
BUILDDEPS = utils/module-init-tools

WORKSRC = $(WORKDIR)/$(DISTNAME)/linux-core

DRM_MODULES = i810 i830 i915 r128 radeon via

BUILD_SCRIPTS   = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = custom

BUILD_ARGS = $(LINUX_MAKE_ARGS) LINUXDIR="$(DESTDIR)$(LINUX_SOURCEDIR)" DRM_MODULES="$(DRM_MODULES)"

BUILD_ENV = $(LINUX_MAKE_ENV)

GAR_EXTRA_CONF += kernel-2.6.17/linux/package-api.mk
include ../../gar.mk

git//%$(DISTNAME).tar.bz2:
	@$(call FETCH_GIT, $*, $(GARVERSION), $(DISTNAME))
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

install-custom:
	@mkdir -p "$(DESTDIR)$(LINUX_MODULESDIR)/misc/drm/"
	@cp $(WORKSRC)/*.ko "$(DESTDIR)$(LINUX_MODULESDIR)/misc/drm/"
	@depmod -b "$(DESTDIR)$(rootdir)" "$(LINUX_FULL_VERSION)"
	@$(MAKECOOKIE)

clean-all:
	@$(MAKE) clean
	@rm -rf "$(DESTDIR)$(LINUX_MODULESDIR)/misc/drm/"
