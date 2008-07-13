GARNAME = liberation-fonts
GARVERSION = 1.04
CATEGORIES = fonts
MASTER_SITES = http://fedorahosted.org/releases/l/i/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = $(GARNAME) GPL2
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/License.txt

DESCRIPTION =
define BLURB
endef

#DISTNAME = $(GARNAME)

INSTALL_SCRIPTS = custom

include ../../gar.mk

install-custom:
	@mkdir -p $(DESTDIR)$(libdir)/X11/fonts/TTF
	@cp -f $(WORKSRC)/*.ttf $(DESTDIR)$(libdir)/X11/fonts/TTF
	@cp -f $(WORKSRC)/LiberationMono-Bold.ttf        $(DESTDIR)$(libdir)/X11/fonts/TTF
	@cp -f $(WORKSRC)/LiberationMono-BoldItalic.ttf  $(DESTDIR)$(libdir)/X11/fonts/TTF
	@cp -f $(WORKSRC)/LiberationMono-Italic.ttf      $(DESTDIR)$(libdir)/X11/fonts/TTF
	@cp -f $(WORKSRC)/LiberationMono-Regular.ttf     $(DESTDIR)$(libdir)/X11/fonts/TTF
	@cp -f $(WORKSRC)/LiberationSans-Bold.ttf        $(DESTDIR)$(libdir)/X11/fonts/TTF
	@cp -f $(WORKSRC)/LiberationSans-BoldItalic.ttf  $(DESTDIR)$(libdir)/X11/fonts/TTF
	@cp -f $(WORKSRC)/LiberationSans-Italic.ttf      $(DESTDIR)$(libdir)/X11/fonts/TTF
	@cp -f $(WORKSRC)/LiberationSans-Regular.ttf     $(DESTDIR)$(libdir)/X11/fonts/TTF
	@cp -f $(WORKSRC)/LiberationSerif-Bold.ttf       $(DESTDIR)$(libdir)/X11/fonts/TTF
	@cp -f $(WORKSRC)/LiberationSerif-BoldItalic.ttf $(DESTDIR)$(libdir)/X11/fonts/TTF
	@cp -f $(WORKSRC)/LiberationSerif-Italic.ttf     $(DESTDIR)$(libdir)/X11/fonts/TTF
	@cp -f $(WORKSRC)/LiberationSerif-Regular.ttf    $(DESTDIR)$(libdir)/X11/fonts/TTF
	@$(MAKECOOKIE)

clean-all:
	@$(MAKE) clean
	@rm -f  $(DESTDIR)$(libdir)/X11/fonts/TTF/LiberationMono-Bold.ttf
	@rm -f  $(DESTDIR)$(libdir)/X11/fonts/TTF/LiberationMono-BoldItalic.ttf
	@rm -f  $(DESTDIR)$(libdir)/X11/fonts/TTF/LiberationMono-Italic.ttf
	@rm -f  $(DESTDIR)$(libdir)/X11/fonts/TTF/LiberationMono-Regular.ttf
	@rm -f  $(DESTDIR)$(libdir)/X11/fonts/TTF/LiberationSans-Bold.ttf
	@rm -f  $(DESTDIR)$(libdir)/X11/fonts/TTF/LiberationSans-BoldItalic.ttf
	@rm -f  $(DESTDIR)$(libdir)/X11/fonts/TTF/LiberationSans-Italic.ttf
	@rm -f  $(DESTDIR)$(libdir)/X11/fonts/TTF/LiberationSans-Regular.ttf
	@rm -f  $(DESTDIR)$(libdir)/X11/fonts/TTF/LiberationSerif-Bold.ttf
	@rm -f  $(DESTDIR)$(libdir)/X11/fonts/TTF/LiberationSerif-BoldItalic.ttf
	@rm -f  $(DESTDIR)$(libdir)/X11/fonts/TTF/LiberationSerif-Italic.ttf
	@rm -f  $(DESTDIR)$(libdir)/X11/fonts/TTF/LiberationSerif-Regular.ttf
	@rm -fr $(DESTDIR)$(licensedir)/$(GARNAME)
