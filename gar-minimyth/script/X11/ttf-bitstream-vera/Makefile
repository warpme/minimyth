GARNAME = ttf-bitstream-vera
GARVERSION = 1.10
CATEGORIES = X11
MASTER_SITES = http://ftp.gnome.org/pub/GNOME/sources/$(GARNAME)/$(GARVERSION)/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/copyright.txt

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c xorg/xorg

BUILD_SCRIPTS   = rename
INSTALL_SCRIPTS = custom

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes=$(DESTDIR)$(includedir) \
	--x-libraries=$(DESTDIR)$(libdir) \
	--with-x

include ../../gar.mk

build-rename:
	@cd $(WORKSRC) ; $(foreach file, $(shell cd $(WORKSRC) ; ls -1 | sed 's%^[^A-Z]*$$%%'), mv $(file) $(shell echo $(file) | tr '[A-Z]' '[a-z]') ; )
	@$(MAKECOOKIE)

install-custom:
	@mkdir -p $(DESTDIR)$(libdir)/X11/fonts/TTF
	@cp -f $(WORKSRC)/*.ttf $(DESTDIR)$(libdir)/X11/fonts/TTF
	@$(MAKECOOKIE)
