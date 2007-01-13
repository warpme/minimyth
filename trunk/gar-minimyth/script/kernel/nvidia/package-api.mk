NVIDIA_SUPER_VERSION = $(strip \
	$(if $(filter i386,  $(KERNEL_ARCH)),x86   ) \
	$(if $(filter x86_64,$(KERNEL_ARCH)),x86_64))
NVIDIA_MAJOR_VERSION = 1
NVIDIA_MINOR_VERSION = 0
NVIDIA_TEENY_VERSION = 8178
NVIDIA_EXTRA_VERSION = $(strip \
	$(if $(filter x86,   $(NVIDIA_SUPER_VERSION)),pkg1) \
	$(if $(filter x86_64,$(NVIDIA_SUPER_VERSION)),pkg2))

NVIDIA_VERSION = $(NVIDIA_MAJOR_VERSION).$(NVIDIA_MINOR_VERSION)-$(NVIDIA_TEENY_VERSION)

NVIDIA_DISTFILE = NVIDIA-Linux-$(NVIDIA_SUPER_VERSION)-$(NVIDIA_VERSION)-$(NVIDIA_EXTRA_VERSION)

include $(GARDIR)/kernel/linux/package-api.mk
