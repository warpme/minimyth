GARNAME = blootubelite-wide
GARVERSION = 20070521
CATEGORIES = $(CATEGORY)
MASTER_SITE = http://www.mythtvtalk.com/juski/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c $(CATEGORY)/mythtv

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

INSTALL_SCRIPTS  = custom

CONFIGURE_ENV = $(MYTHTV_CONFIGURE_ENV)
BUILD_ENV     = $(MYTHTV_BUILD_ENV)
INSTALL_ENV   = $(MYTHTV_INSTALL_ENV)

GAR_EXTRA_CONF += $(CATEGORY)/myth/package-api.mk
include ../../gar.mk

install-custom:
	@mkdir -p $(DESTDIR)$(datadir)/mythtv/themes
	@rm -rf $(DESTDIR)$(datadir)/mythtv/themes/$(GARNAME)
	@cp -af $(WORKSRC) $(DESTDIR)$(datadir)/mythtv/themes/$(GARNAME)
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
