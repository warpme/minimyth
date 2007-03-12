GARNAME = IEGD
GARVERSION = 6.1
CATEGORIES = $(CATEGORY)
MASTER_SITES = http://nixda.biz/zenega/
DISTFILES = $(GARNAME)_$(subst .,_,$(GARVERSION))_Linux.tgz
LICENSE = IEGD
IEGD_LICENSE_TEXT=$(WORKSRC)/License/License.txt

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

WORKSRC = $(WORKDIR)/$(GARNAME)_$(subst .,_,$(GARVERSION))_Linux

X_DRIVER=$(strip \
		$(if $(filter 7.0,$(mm_XORG_VERSION)),Xorg-X11R7.0) \
		$(if $(filter 7.1,$(mm_XORG_VERSION)),Xorg-X11R7.0) \
		$(if $(filter 7.2,$(mm_XORG_VERSION)),Xorg-X11R7.0) \
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

pre-install:
	mkdir -p $(DESTDIR)$(LINUX_MODULESDIR)/misc/iegd/drivers/char/drm
	@$(MAKECOOKIE)

install-custom-drm:
	@depmod -b "$(DESTDIR)$(rootdir)" "$(LINUX_FULL_VERSION)"
	@$(MAKECOOKIE)

install-custom:
	@mkdir -p $(DESTDIR)$(includedir)/X11
	@install $(WORKSRC)/Driver/$(X_DRIVER)/intel_escape.h \
		$(DESTDIR)$(includedir)/X11
	@mkdir -p $(DESTDIR)$(libdir)
	@install $(WORKSRC)/Driver/$(X_DRIVER)/libXiegd_escape.so.2.0.0 \
		$(DESTDIR)$(libdir)
	@mkdir -p $(DESTDIR)$(libdir)/xorg/modules/
	@install $(WORKSRC)/Driver/$(X_DRIVER)/fs454.so \
		$(DESTDIR)$(libdir)/xorg/modules
	@mkdir -p $(DESTDIR)$(libdir)/xorg/modules/drivers
	@install $(WORKSRC)/Driver/$(X_DRIVER)/intel_drv.so \
		$(DESTDIR)$(libdir)/xorg/modules/drivers
	@cd $(DESTDIR)$(libdir) ; \
		ln -sf libXiegd_escape.so.2.0.0 \
		       libXiegd_escape.so.2.0 ; \
		ln -sf libXiegd_escape.so.2.0 \
		       libXiegd_escape.so.2 ; \
		ln -sf libXiegd_escape.so.2 \
		       libXiegd_escape.so
	@mkdir -p $(DESTDIR)$(mandir)/man3
	@install $(WORKSRC)/Documents/Xorg-X11/IntelEscape.3x \
		$(DESTDIR)$(mandir)/man3
	@mkdir -p $(DESTDIR)$(mandir)/man4
	@install $(WORKSRC)/Documents/Xorg-X11/intel.4 \
		$(DESTDIR)$(mandir)/man4
	@$(MAKECOOKIE)
