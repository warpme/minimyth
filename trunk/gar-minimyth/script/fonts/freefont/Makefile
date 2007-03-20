GARNAME = freefont
GARVERSION = 20060126
CATEGORIES = fonts
MASTER_SITES = http://download.savannah.gnu.org/releases/freefont/
DISTFILES = $(GARNAME)-ttf-$(GARVERSION).tar.gz
LICENSE = GPL

DESCRIPTION =
define BLURB
endef

INSTALL_SCRIPTS = custom

include ../../gar.mk

install-custom:
	@mkdir -p $(DESTDIR)$(libdir)/X11/fonts/TTF
	@cp -f $(WORKSRC)/*.ttf $(DESTDIR)$(libdir)/X11/fonts/TTF
	@$(MAKECOOKIE)
