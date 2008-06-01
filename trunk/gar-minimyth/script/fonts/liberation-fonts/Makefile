GARNAME = liberation-fonts
GARVERSION =
CATEGORIES = fonts
MASTER_SITES = http://www.redhat.com/f/fonts/
DISTFILES = $(DISTNAME).zip
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/COPYING

DESCRIPTION =
define BLURB
endef

DISTNAME = $(GARNAME)

INSTALL_SCRIPTS = custom

include ../../gar.mk

install-custom:
	@mkdir -p $(DESTDIR)$(libdir)/X11/fonts/TTF
	@cp -f $(WORKSRC)/*.ttf $(DESTDIR)$(libdir)/X11/fonts/TTF
	@$(MAKECOOKIE)
