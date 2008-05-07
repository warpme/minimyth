PATCHFILES = $(DISTFILE)-2305230.patch $(DISTFILE)-select_makefile.patch

NVIDIA_MAJOR_VERSION = 71
NVIDIA_MINOR_VERSION = 86
NVIDIA_TEENY_VERSION = 04

BUILD_SCRIPTS   = nvidia
INSTALL_SCRIPTS = nvidia

BUILD_ARGS = $(NVIDIA_MAKE_ARGS)
BUILD_ENV  = $(NVIDIA_MAKE_ENV)

GAR_EXTRA_CONF += kernel-$(mm_KERNEL_VERSION)/linux/package-api.mk nvidia/nvidia/package-api.mk 
include ../../gar.mk
