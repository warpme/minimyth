GARNAME = freefont-ttf
GARVERSION = 20060126
CATEGORIES = xorg-new
MASTER_SITES = http://download.savannah.gnu.org/releases/freefont/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

BUILDDEPS = xorg-new/mkfontdir xorg-new/mkfontscale

WORKSRC = $(WORKDIR)/freefont-$(GARVERSION)

INSTALL_SCRIPTS = custom

include ../../gar.mk

install-custom:
	@mkdir -p $(DESTDIR)$(libdir)/X11/fonts/TTF
	@cp -f $(WORKSRC)/Free*.ttf $(DESTDIR)$(libdir)/X11/fonts/TTF/
	@cd $(DESTDIR)$(libdir)/X11/fonts/TTF ; mkfontscale . ; mkfontdir .
	@$(MAKECOOKIE)
