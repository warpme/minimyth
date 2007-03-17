GARNAME = linux-headers
GARVERSION = $(mm_KERNEL_VERSION)
CATEGORIES = kernel-headers
LICENSE =

DESCRIPTION = 
define BLURB
endef

mm_KERNEL_HEADERS_VERSION = 2.6.12

DEPENDS = kernel-headers/linux-headers-$(mm_KERNEL_HEADERS_VERSION)

include ../../gar.mk

post-install:
	@rm -rf $(DESTDIR)$(versiondir)/$(GARNAME)
	@rm -rf $(DESTDIR)$(licensedir)/$(GARNAME)
	@$(MAKECOOKIE)
