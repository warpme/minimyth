GARNAME = kernel
GARVERSION = 2.6.19
CATEGORIES = kernel-2.6.19
LICENSE =

DESCRIPTION = 
define BLURB
endef

DEPENDS = \
	kernel-2.6.19/alsa-driver \
	kernel-2.6.19/drm \
	kernel-2.6.19/imon_vfd \
	kernel-2.6.19/linux \
	kernel-2.6.19/linux-headers \

GAR_EXTRA_CONF += kernel-2.6.19/linux/package-api.mk
include ../../gar.mk

post-install:
	@rm -rf $(DESTDIR)$(versiondir)/$(GARNAME)
	@rm -rf $(DESTDIR)$(licensedir)/$(GARNAME)
	@$(MAKECOOKIE)

clean-all:
	@$(MAKE) clean     -C ../alsa-driver
	@$(MAKE) clean     -C ../drm
	@$(MAKE) clean     -C ../imon_vfd
	@$(MAKE) clean     -C ../kernel
	@$(MAKE) clean     -C ../linux
	@$(MAKE) clean     -C ../../lirc
	@$(MAKE) clean-all -C ../../nvidia
	@rm -rf $(DESTDIR)$(LINUX_DIR)
	@rm -rf $(DESTDIR)$(LINUX_MODULESPREFIX)
