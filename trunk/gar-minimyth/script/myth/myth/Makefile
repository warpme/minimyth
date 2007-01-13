GARNAME = myth
GARVERSION =
CATEGORIES = myth

DESCRIPTION =  Meta package for building the correct version of Myth
define BLURB
endef

PWD := $(shell pwd)

DEPENDS += myth/mythtv myth/myththemes myth/mythplugins myth/mythstream

include ../../gar.mk

pre-fetch:
	@cd $(PWD)/.. ; ln -s mythtv-$(mm_MYTH_VERSION)      mythtv
	@cd $(PWD)/.. ; ln -s myththemes-$(mm_MYTH_VERSION)  myththemes
	@cd $(PWD)/.. ; ln -s mythplugins-$(mm_MYTH_VERSION) mythplugins
	@$(MAKECOOKIE)

clean-all:
	@$(foreach dir,$(wildcard ../myth*),$(MAKE) -C $(dir) clean ; )
	@cd $(PWD)/.. ; rm -rf mythtv
	@cd $(PWD)/.. ; rm -rf myththemes
	@cd $(PWD)/.. ; rm -rf mythplugins
	@rm -rf $(DESTDIR)$(bindir)/myth*
	@rm -rf $(DESTDIR)$(datadir)/myth*
	@rm -rf $(DESTDIR)$(includedir)/myth*
	@rm -rf $(DESTDIR)$(libdir)/libmyth*
	@rm -rf $(DESTDIR)$(libdir)/myth*
