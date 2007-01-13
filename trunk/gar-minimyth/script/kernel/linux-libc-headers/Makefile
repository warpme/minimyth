GARNAME = linux-libc-headers
GARVERSION = 2.6.10.0
CATEGORIES = kernel
MASTER_SITES = http://ep09.pld-linux.org/~mmazur/linux-libc-headers/
DISTFILES = $(GARNAME)-$(GARVERSION).tar.bz2
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

INSTALL_SCRIPTS = custom

GAR_EXTRA_CONF += kernel/linux/package-api.mk
include ../../gar.mk

install-custom:
	@mkdir -p $(DESTDIR)$(includedir)/asm
	@cp -r $(WORKSRC)/include/asm-$(KERNEL_ARCH)/* $(DESTDIR)$(includedir)/asm
	@cp -r $(WORKSRC)/include/linux $(DESTDIR)$(includedir)
	@rm -f $(DESTDIR)$(includedir)/linux/config.h
	@touch $(DESTDIR)$(includedir)/linux/config.h
	@$(MAKECOOKIE)
