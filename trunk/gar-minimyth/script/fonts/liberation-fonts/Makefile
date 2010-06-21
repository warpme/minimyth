GARNAME = liberation-fonts
GARVERSION = 1.05.3.20100621
CATEGORIES = fonts
MASTER_SITES = http://fedorahosted.org/releases/l/i/$(GARNAME)/
DISTFILES = $(GARNAME)-ttf-$(GARVERSION).tar.gz
LICENSE = $(GARNAME) GPL3
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/License.txt

DESCRIPTION =
define BLURB
endef

WORKSRC = $(WORKDIR)

INSTALL_SCRIPTS = custom

include ../../gar.mk

install-custom:
	@mkdir -p $(DESTDIR)$(datadir)/fonts/X11/TTF
	@cp -f $(WORKSRC)/ttf/LiberationMono-Bold.ttf        $(DESTDIR)$(datadir)/fonts/X11/TTF
	@cp -f $(WORKSRC)/ttf/LiberationMono-BoldItalic.ttf  $(DESTDIR)$(datadir)/fonts/X11/TTF
	@cp -f $(WORKSRC)/ttf/LiberationMono-Italic.ttf      $(DESTDIR)$(datadir)/fonts/X11/TTF
	@cp -f $(WORKSRC)/ttf/LiberationMono-Regular.ttf     $(DESTDIR)$(datadir)/fonts/X11/TTF
	@cp -f $(WORKSRC)/ttf/LiberationSans-Bold.ttf        $(DESTDIR)$(datadir)/fonts/X11/TTF
	@cp -f $(WORKSRC)/ttf/LiberationSans-BoldItalic.ttf  $(DESTDIR)$(datadir)/fonts/X11/TTF
	@cp -f $(WORKSRC)/ttf/LiberationSans-Italic.ttf      $(DESTDIR)$(datadir)/fonts/X11/TTF
	@cp -f $(WORKSRC)/ttf/LiberationSans-Regular.ttf     $(DESTDIR)$(datadir)/fonts/X11/TTF
	@cp -f $(WORKSRC)/ttf/LiberationSerif-Bold.ttf       $(DESTDIR)$(datadir)/fonts/X11/TTF
	@cp -f $(WORKSRC)/ttf/LiberationSerif-BoldItalic.ttf $(DESTDIR)$(datadir)/fonts/X11/TTF
	@cp -f $(WORKSRC)/ttf/LiberationSerif-Italic.ttf     $(DESTDIR)$(datadir)/fonts/X11/TTF
	@cp -f $(WORKSRC)/ttf/LiberationSerif-Regular.ttf    $(DESTDIR)$(datadir)/fonts/X11/TTF
	@$(MAKECOOKIE)

clean-all:
	@$(MAKE) clean
	@rm -f  $(DESTDIR)$(datadir)/fonts/X11/TTF/LiberationMono-Bold.ttf
	@rm -f  $(DESTDIR)$(datadir)/fonts/X11/TTF/LiberationMono-BoldItalic.ttf
	@rm -f  $(DESTDIR)$(datadir)/fonts/X11/TTF/LiberationMono-Italic.ttf
	@rm -f  $(DESTDIR)$(datadir)/fonts/X11/TTF/LiberationMono-Regular.ttf
	@rm -f  $(DESTDIR)$(datadir)/fonts/X11/TTF/LiberationSans-Bold.ttf
	@rm -f  $(DESTDIR)$(datadir)/fonts/X11/TTF/LiberationSans-BoldItalic.ttf
	@rm -f  $(DESTDIR)$(datadir)/fonts/X11/TTF/LiberationSans-Italic.ttf
	@rm -f  $(DESTDIR)$(datadir)/fonts/X11/TTF/LiberationSans-Regular.ttf
	@rm -f  $(DESTDIR)$(datadir)/fonts/X11/TTF/LiberationSerif-Bold.ttf
	@rm -f  $(DESTDIR)$(datadir)/fonts/X11/TTF/LiberationSerif-BoldItalic.ttf
	@rm -f  $(DESTDIR)$(datadir)/fonts/X11/TTF/LiberationSerif-Italic.ttf
	@rm -f  $(DESTDIR)$(datadir)/fonts/X11/TTF/LiberationSerif-Regular.ttf
	@rm -fr $(DESTDIR)$(licensedir)/$(GARNAME)
