GARNAME = kernel
GARVERSION = $(mm_KERNEL_VERSION)
CATEGORIES = kernel
LICENSE =

DESCRIPTION = 
define BLURB
endef

DEPENDS = kernel-$(mm_KERNEL_VERSION)/kernel

include ../../gar.mk

post-install:
	@rm -rf $(DESTDIR)$(versiondir)/$(GARNAME)
	@rm -rf $(DESTDIR)$(licensedir)/$(GARNAME)
	@ln -sf mksquashfs-$(if $(filter $(GARVERSION),2.6.26 2.6.27 2.6.28),3.4,4.0) $(DESTDIR)$(bindir)/mksquashfs
	@ln -sf mksquashfs-$(if $(filter $(GARVERSION),2.6.26 2.6.27 2.6.28),3.4,4.0) $(build_DESTDIR)$(build_bindir)/mksquashfs

clean-all:
	@$(foreach dir, $(wildcard ../../kernel-2.*), $(MAKE) clean-all -C $(dir)/kernel ; )
	@$(MAKE) clean
