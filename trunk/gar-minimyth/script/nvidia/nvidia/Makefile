GARNAME = nvidia
GARVERSION = $(mm_NVIDIA_VERSION)
CATEGORIES = nvidia
LICENSE =

DESCRIPTION = 
define BLURB
endef

include ../../gar.mk

clean-all:
	@$(foreach dir, $(wildcard ../nvidia-*), $(MAKE) clean-all -C $(dir) ; )
	@$(MAKE) clean
