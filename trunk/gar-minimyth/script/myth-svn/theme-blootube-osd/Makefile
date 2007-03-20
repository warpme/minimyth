GARNAME = blootube-osd
GARVERSION = 20070107
CATEGORIES = $(CATEGORY)
MASTER_SITE = http://www.mythtvtalk.com/juski/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-font.patch $(DISTNAME)-fadeaway.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c $(CATEGORY)/mythtv

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

BUILD_SCRIPTS   = custom
INSTALL_SCRIPTS = custom

include ../../gar.mk

build-custom:
	@rm -rf $(WORKSRC)/*.ttf
	@$(MAKECOOKIE)

install-custom:
	@rm -rf $(DESTDIR)$(sharedstatedir)/mythtv/themes/$(GARNAME)
	@cp -af $(WORKSRC) $(DESTDIR)$(sharedstatedir)/mythtv/themes/$(GARNAME)
	@$(MAKECOOKIE)

theme-tarball:
	@$(MAKE) clean
	@mkdir -p $(PARTIALDIR)
	@wget -c -P $(PARTIALDIR) $(MASTER_SITE)/$(GARNAME).tar.bz2
	@mkdir -p $(DOWNLOADDIR)
	@mv $(PARTIALDIR)/$(GARNAME).tar.bz2 $(DOWNLOADDIR)/$(GARNAME).tar.bz2
	@mkdir -p $(WORKDIR)
	@tar -C $(WORKDIR) -jxf $(DOWNLOADDIR)/$(GARNAME).tar.bz2
	@rm -f $(DOWNLOADDIR)/$(GARNAME).tar.bz2
	@mv $(WORKDIR)/$(GARNAME) $(WORKDIR)/$(DISTNAME)
	@tar -C $(WORKDIR) -jcf $(DOWNLOADDIR)/$(DISTNAME).tar.bz2 $(DISTNAME)
