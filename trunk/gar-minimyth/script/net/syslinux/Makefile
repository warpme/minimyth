GARNAME = syslinux
GARVERSION = 3.81
CATEGORIES = net
MASTER_SITES = http://www.kernel.org/pub/linux/utils/boot/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS   = lang/c

INSTALL_SCRIPTS = custom

include ../../gar.mk

install-custom:
	@mkdir -p $(DESTDIR)$(rootdir)/srv/tftpboot/minimyth
	@cp -f $(WORKSRC)/core/pxelinux.0 $(DESTDIR)$(rootdir)/srv/tftpboot/minimyth/pxelinux.0
	@mkdir -p $(DESTDIR)$(rootdir)/srv/tftpboot/minimyth/pxelinux.cfg
	@$(MAKECOOKIE)
