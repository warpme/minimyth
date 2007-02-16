GARNAME = kernel
GARVERSION = 2.6.20
CATEGORIES = kernel-2.6.20
LICENSE =

DESCRIPTION = 
define BLURB
endef

DEPENDS = \
	kernel-2.6.20/alsa-driver \
	kernel-2.6.20/drm \
	kernel-2.6.20/imon_vfd \
	kernel-2.6.20/linux \
	kernel-2.6.20/linux-headers \
	kernel-2.6.20/xbox360

GAR_EXTRA_CONF += kernel-2.6.20/linux/package-api.mk
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
	@$(MAKE) clean     -C ../xbox360
	@$(MAKE) clean-all -C ../../nvidia
	@$(MAKE) clean-all -C ../../system/lirc
	@$(MAKE) clean     -C ../../X11/IEGD
	@rm -rf $(DESTDIR)$(LINUX_DIR)
	@rm -rf $(DESTDIR)$(LINUX_MODULESPREFIX)
