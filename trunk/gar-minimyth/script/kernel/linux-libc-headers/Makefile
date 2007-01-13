GARNAME = linux-libc-headers
GARVERSION = 2.6.12.0
CATEGORIES = kernel
MASTER_SITES = http://ep09.pld-linux.org/~mmazur/linux-libc-headers/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-agpgart_h.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

INSTALL_SCRIPTS = custom

include ../../gar.mk

install-custom:
	@mkdir -p $(DESTDIR)$(includedir)/asm
	@cp -r $(WORKSRC)/include/asm-$(GARCH_FAMILY)/* $(DESTDIR)$(includedir)/asm
	@cp -r $(WORKSRC)/include/linux $(DESTDIR)$(includedir)
	@rm -f $(DESTDIR)$(includedir)/linux/config.h
	@touch $(DESTDIR)$(includedir)/linux/config.h
	@$(MAKECOOKIE)
