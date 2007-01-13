################################################################################
# extras.mk
################################################################################

MM_EXTRAS_URL   = $(shell mm_var_get MM_EXTRAS_URL)
MM_TFTP_ROOTDIR = $(shell mm_var_get MM_TFTP_ROOTDIR)
MM_TFTP_SERVER  = $(shell mm_var_get MM_TFTP_SERVER)

EXTRAS_INITRD_DIR  = $(dir ${initrd})
EXTRAS_INITRD_FILE = $(notdir ${initrd})
EXTRAS_DIR         = $(EXTRAS_INITRD_DIR)
EXTRAS_FILE        = $(addsuffix .tar.bz2,$(patsubst rootfs%,extras%,$(EXTRAS_INITRD_FILE)))
EXTRAS_FILE_VALID  = $(if $(filter rootfs%,$(EXTRAS_INITRD_FILE)),yes,no)
EXTRAS_URL         = $(strip \
	$(if $(filter $(MM_EXTRAS_URL),default), \
		$(if $(filter $(EXTRAS_FILE_VALID),yes), \
			tftp://$(MM_TFTP_SERVER)/$(MM_TFTP_ROOTDIR)/$(EXTRAS_DIR)/$(EXTRAS_FILE), \
			\
		), \
		$(MM_EXTRAS_URL) \
	))

extras: /usr/local
	touch extras

/usr/local: /etc mm_var_get mm_url_mount
	$(if $(EXTRAS_URL),mm_url_mount "$(EXTRAS_URL)" "/usr/local")
	ldconfig -f /etc/ld.so.conf -C /etc/ld.so.cache
