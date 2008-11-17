NVIDIA_MAJOR_VERSION = 180
NVIDIA_MINOR_VERSION = 06
NVIDIA_TEENY_VERSION =

INSTALL_SCRIPTS = libs includes

GAR_EXTRA_CONF += kernel-$(mm_KERNEL_VERSION)/linux/package-api.mk nvidia/nvidia/package-api.mk 
include ../../gar.mk

NVIDIA_FILE_LIST_BIN =
NVIDIA_FILE_LIST_LIB_DRV =
NVIDIA_FILE_LIST_LIB_SO  = $(strip \
		$(if $(wildcard $(WORKSRC)/usr/lib/libvdpau.so.*), \
			libvdpau.so:/usr/lib:$(libdir)) \
	)

install-libs: install-nvidia-x11
	@$(MAKECOOKIE)
	
install-includes:
	@mkdir -p $(DESTDIR)$(includedir)
	@rm -rf $(DESTDIR)$(includedir)/vdpau
	@cp -r $(WORKSRC)/usr/include/vdpau $(DESTDIR)$(includedir)
	@$(MAKECOOKIE)
