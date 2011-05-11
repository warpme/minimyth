GARNAME = linux-firmware
GARVERSION = 20110511
CATEGORIES = kernel-2.6.38
MASTER_SITES = http://www.kernel.org/pub/linux/kernel/people/dwmw2/firmware/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE =

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c kernel-2.6.38/linux

INSTALL_SCRIPTS = custom

include ../../gar.mk

install-custom:
	@mkdir -p $(DESTDIR)$(elibdir)/firmware/
	@cp -Rdf $(WORKSRC)/* $(DESTDIR)$(elibdir)/firmware/
	@$(MAKECOOKIE)
