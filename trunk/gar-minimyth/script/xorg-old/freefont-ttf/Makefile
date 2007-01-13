GARNAME = freefont-ttf
GARVERSION = 20050407
CATEGORIES = xorg-old
MASTER_SITES = http://download.savannah.gnu.org/releases/freefont/
DISTFILES = $(GARNAME).tar.gz
LICENSE =

DESCRIPTION = 
define BLURB
endef

INSTALL_SCRIPTS = custom

include ../../gar.mk

WORKSRC = $(WORKDIR)

install-custom:
	@mkdir -p $(DESTDIR)$(libdir)/X11/fonts/TTF
	@cp -f $(WORKSRC)/sfd/Free*.ttf $(DESTDIR)$(libdir)/X11/fonts/TTF/
	@$(MAKECOOKIE)
