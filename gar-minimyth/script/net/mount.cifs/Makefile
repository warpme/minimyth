GARNAME = mount.cifs
GARVERSION = 3.3.0
CATEGORIES = net
DISTFILES = samba-$(GARVERSION).tar.gz
MASTER_SITES = http://us1.samba.org/samba/ftp/stable/
PATCHFILES = $(DISTNAME)-sys_stat_h.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

WORKSRC = $(WORKDIR)/samba-$(GARVERSION)/source/client

BUILD_SCRIPTS   = custom
INSTALL_SCRIPTS = custom

include ../../gar.mk

build-custom:
	@$(BUILD_ENV) cd $(WORKSRC) ; $(CC) -o mount.cifs $(CFLAGS) mount.cifs.c mtab.c
	@$(MAKECOOKIE)

install-custom:
	@$(INSTALL_ENV) install -m755 $(WORKSRC)/mount.cifs $(DESTDIR)$(esbindir)/mount.cifs
	@$(MAKECOOKIE)
