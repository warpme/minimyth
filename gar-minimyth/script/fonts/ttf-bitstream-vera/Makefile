GARNAME = ttf-bitstream-vera
GARVERSION = 1.10
CATEGORIES = fonts
MASTER_SITES = http://ftp.gnome.org/pub/GNOME/sources/$(GARNAME)/$(GARVERSION)/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/COPYRIGHT.TXT

DESCRIPTION =
define BLURB
endef

INSTALL_SCRIPTS = custom

include ../../gar.mk

install-custom:
	@mkdir -p $(DESTDIR)$(libdir)/X11/fonts/TTF
	@cp -f $(WORKSRC)/*.ttf $(DESTDIR)$(libdir)/X11/fonts/TTF
	@$(MAKECOOKIE)
