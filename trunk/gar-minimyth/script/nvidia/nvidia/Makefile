GARNAME = nvidia
GARVERSION = $(mm_NVIDIA_VERSION)
CATEGORIES = nvidia
LICENSE =

DESCRIPTION = 
define BLURB
endef

DEPENDS = nvidia/nvidia-$(mm_NVIDIA_VERSION)

include ../../gar.mk

post-install:
	@rm -rf $(DESTDIR)$(versiondir)/$(GARNAME)
	@rm -rf $(DESTDIR)$(licensedir)/$(GARNAME)
	@$(MAKECOOKIE)

clean-all:
	@$(foreach dir, $(wildcard ../nvidia-*), $(MAKE) clean-all -C $(dir) ; )
	@$(MAKE) clean
