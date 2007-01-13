NFORCE_SUPER_VERSION = $(strip \
	$(if $(filter i386,  $(GARCH_FAMILY)),x86   ) \
	$(if $(filter x86_64,$(GARCH_FAMILY)),x86_64))
NFORCE_MAJOR_VERSION = 1
NFORCE_MINOR_VERSION = 0
NFORCE_TEENY_VERSION = 0310
NFORCE_EXTRA_VERSION = $(strip \
	$(if $(filter x86,   $(NFORCE_SUPER_VERSION)),pkg1) \
	$(if $(filter x86_64,$(NFORCE_SUPER_VERSION)),pkg1))

NFORCE_VERSION = $(NFORCE_MAJOR_VERSION).$(NFORCE_MINOR_VERSION)-$(NFORCE_TEENY_VERSION)

NFORCE_DISTFILE = NFORCE-Linux-$(NFORCE_SUPER_VERSION)-$(NFORCE_VERSION)-$(NFORCE_EXTRA_VERSION)
