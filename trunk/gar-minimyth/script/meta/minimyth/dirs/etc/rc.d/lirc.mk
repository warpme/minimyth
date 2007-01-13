################################################################################
# lirc.mk
################################################################################

MM_LIRC_DEVICE                = $(shell mm_var_get MM_LIRC_DEVICE)
MM_LIRC_DRIVER                = $(shell mm_var_get MM_LIRC_DRIVER)
MM_LIRC_KERNEL_MODULE         = $(shell mm_var_get MM_LIRC_KERNEL_MODULE)
MM_LIRC_KERNEL_MODULE_OPTIONS = $(shell mm_var_get MM_LIRC_KERNEL_MODULE_OPTIONS)
MM_LIRC_REMOTE                = $(shell mm_var_get MM_LIRC_REMOTE)

LIRC_DRIVER                = $(strip $(MM_LIRC_DRIVER))
LIRC_DEVICE                = $(strip \
	$(if $(MM_LIRC_DEVICE),$(MM_LIRC_DEVICE), \
		$(if $(filter $(LIRC_DRIVER),irman ),/dev/ttyS0) \
		$(if $(filter $(LIRC_DRIVER),mceusb),/dev/lirc0) \
		$(if $(filter $(LIRC_DRIVER),serial),/dev/lirc0) \
	))
LIRC_KERNEL_MODULE         = $(strip \
	$(if $(MM_LIRC_KERNEL_MODULE), $(MM_LIRC_KERNEL_MODULE), \
		$(if $(filter $(LIRC_DRIVER),irman ),8250) \
		$(if $(filter $(LIRC_DRIVER),mceusb),lirc_mceusb) \
		$(if $(filter $(LIRC_DRIVER),serial),lirc_serial) \
	))
LIRC_KERNEL_MODULE_OPTIONS = $(strip \
	$(if $(MM_LIRC_KERNEL_MODULE_OPTIONS), $(MM_LIRC_KERNEL_MODULE_OPTIONS), \
		$(if $(filter $(LIRC_DRIVER),irman ),) \
		$(if $(filter $(LIRC_DRIVER),mceusb),) \
		$(if $(filter $(LIRC_DRIVER),serial),) \
	))
LIRC_REMOTE                = $(strip $(MM_LIRC_REMOTE))

LIRC_LIRCD_COMMAND = $(strip \
	$(if $(wildcard /usr/sbin/lircd.$(LIRC_DRIVER)), \
		lircd.$(LIRC_DRIVER) --device=$(LIRC_DEVICE), \
		lircd.any               --device=$(LIRC_DEVICE) --driver=$(LIRC_DRIVER) \
	))
LIRC_LIRCD_CONF    = $(strip /etc/lirc.d/lircd.conf.$(LIRC_REMOTE).$(LIRC_DRIVER))
LIRC_LIRCRC        = $(strip /etc/lirc.d/lircrc.$(LIRC_REMOTE))

lirc: mm_var_get /dev /etc/lircd.conf /etc/lircrc /var/lock /var/log /var/run
	$(if $(LIRC_KERNEL_MODULE),modprobe $(LIRC_KERNEL_MODULE) $(LIRC_KERNEL_MODULE_OPTIONS))
	$(if $(LIRC_DRIVER),$(if $(LIRC_DEVICE),$(LIRC_LIRCD_COMMAND)))
	touch lirc

/etc/lircd.conf: mm_var_get mm_conf_get /etc
	$(if $(wildcard $(LIRC_LIRCD_CONF)),cp -f $(LIRC_LIRCD_CONF) /etc/lircrc)
	mm_conf_get /lircd.conf /etc/lircd.conf
	touch /etc/lircd.conf
	
/etc/lircrc: mm_var_get mm_conf_get /etc
	$(if $(wildcard $(LIRC_LIRCRC)),cp -f $(LIRC_LIRCRC) /etc/lircrc)
	mm_conf_get /lircrc /etc/lircrc
	touch /etc/lircrc
