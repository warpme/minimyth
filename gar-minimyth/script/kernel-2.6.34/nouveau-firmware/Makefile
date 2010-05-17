GARNAME = nouveau-firmware
GARVERSION = 20091212
CATEGORIES = kernel-2.6.34
MASTER_SITES = http://people.freedesktop.org/~pq/nouveau-drm/
DISTFILES = $(DISTNAME).tar.gz
LICENSE =

DESCRIPTION = 
define BLURB
endef

WORKSRC = $(WORKDIR)/nouveau

INSTALL_SCRIPTS = custom

include ../../gar.mk

install-custom:
	@rm -rf $(DESTDIR)$(elibdir)/firmware/nouveau
	@mkdir -p $(DESTDIR)$(elibdir)/firmware/
	@cp -r $(WORKSRC) $(DESTDIR)$(elibdir)/firmware/
	@$(MAKECOOKIE)
