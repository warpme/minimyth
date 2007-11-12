GARNAME = IEGD
GARVERSION = 8.0
CATEGORIES = $(CATEGORY)
MASTER_SITES =
DISTFILES = $(GARNAME)_$(subst .,_,$(GARVERSION))_Linux.tgz
LICENSE = IEGD
IEGD_LICENSE_TEXT=$(WORKSRC)/License/License.txt

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c kernel/kernel xorg/xorg

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

WORKSRC = $(WORKDIR)/$(GARNAME)_$(subst .,_,$(GARVERSION))_Linux

X_DRIVER=$(strip \
		$(if $(filter 7.2,$(mm_XORG_VERSION)),Xorg-X11R7.2) \
		$(if $(filter 7.3,$(mm_XORG_VERSION)),Xorg-X11R7.2) \
	  )

BUILD_SCRIPTS    = $(if $(filter i386,$(mm_GARCH_FAMILY)),$(WORKDIR)/IEGD_Patches/Drm/Makefile)
INSTALL_SCRIPTS  = $(if $(filter i386,$(mm_GARCH_FAMILY)),$(WORKDIR)/IEGD_Patches/Drm/Makefile custom-drm)
INSTALL_SCRIPTS += $(if $(filter i386,$(mm_GARCH_FAMILY)),custom)

BUILD_ARGS = \
	modules \
	$(LINUX_MAKE_ARGS) \
	KERNELDIR=$(DESTDIR)$(LINUX_BUILDDIR) \
	INSTALL_MOD_PATH=$(DESTDIR)$(LINUX_MODULESDIR)/misc/iegd
INSTALL_ARGS = \
	modules \
	$(LINUX_MAKE_ARGS) \
	KERNELDIR=$(DESTDIR)$(LINUX_BUILDDIR) \
	INSTALL_MOD_PATH=$(DESTDIR)$(LINUX_MODULESDIR)/misc/iegd

BUILD_ENV   = \
	$(LINUX_MAKE_ENV)
INSTALL_ENV = \
	$(LINUX_MAKE_ENV)

GAR_EXTRA_CONF += kernel-$(mm_KERNEL_VERSION)/linux/package-api.mk
include ../../gar.mk

post-patch:
	@cd $(WORKDIR)/IEGD_Patches/Drm ; sed -e 's%#include <linux/config.h>%%g' -i *.c
	@cd $(WORKDIR)/IEGD_Patches/Drm ; sed -e 's%#include <linux/config.h>%%g' -i *.h
	@cd $(WORKDIR)/IEGD_Patches/Drm ; sed -e 's%drm_device_t%struct drm_device%g' -i *.c
	@cd $(WORKDIR)/IEGD_Patches/Drm ; sed -e 's%drm_device_t%struct drm_device%g' -i *.h
	@cd $(WORKDIR)/IEGD_Patches/Drm ; sed -e 's%drm_file_t%struct drm_file%g' -i *.c
	@cd $(WORKDIR)/IEGD_Patches/Drm ; sed -e 's%drm_file_t%struct drm_file%g' -i *.h
	@$(MAKECOOKIE)

pre-install:
	@mkdir -p $(DESTDIR)$(LINUX_MODULESDIR)/misc/iegd/drivers/char/drm
	@$(MAKECOOKIE)

install-custom-drm:
	@depmod -b "$(DESTDIR)$(rootdir)" "$(LINUX_FULL_VERSION)"
	@$(MAKECOOKIE)

install-custom:
	@mkdir -p $(DESTDIR)$(libdir)/iegd
	@install $(WORKSRC)/Driver/$(X_DRIVER)/libGLgn3.so \
		$(DESTDIR)$(libdir)/iegd
	@install $(WORKSRC)/Driver/$(X_DRIVER)/libGLgn4.so \
		$(DESTDIR)$(libdir)/iegd
	@mkdir -p $(DESTDIR)$(libdir)/iegd/xorg/modules/
	@install $(WORKSRC)/Driver/$(X_DRIVER)/libXiegd_escape.so.2.0.0 \
		$(DESTDIR)$(libdir)/iegd
	@mkdir -p $(DESTDIR)$(libdir)/iegd/xorg/modules/
	@install $(WORKSRC)/Driver/$(X_DRIVER)/fs454.so \
		$(DESTDIR)$(libdir)/iegd/xorg/modules
	@mkdir -p $(DESTDIR)$(libdir)/iegd/xorg/modules/drivers
	@install $(WORKSRC)/Driver/$(X_DRIVER)/iegd_drv.so \
		$(DESTDIR)$(libdir)/iegd/xorg/modules/drivers/iegd_drv.so
	@cd $(DESTDIR)$(libdir)/iegd ; \
		ln -sf libXiegd_escape.so.2.0.0 \
		       libXiegd_escape.so.2.0 ; \
		ln -sf libXiegd_escape.so.2.0 \
		       libXiegd_escape.so.2 ; \
		ln -sf libXiegd_escape.so.2 \
		       libXiegd_escape.so
	@mkdir -p $(DESTDIR)$(mandir)/man4
	@install $(WORKSRC)/Documents/Xorg-X11/iegd.4 \
		$(DESTDIR)$(mandir)/man4/iegd.4
	@$(MAKECOOKIE)
