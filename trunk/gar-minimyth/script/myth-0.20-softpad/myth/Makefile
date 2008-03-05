GARNAME = myth
GARVERSION = $(GARVERSION_SHORT)
CATEGORIES = $(CATEGORY)
LICENSE =

DESCRIPTION = 
define BLURB
endef

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

include ../../gar.mk

post-install:
	@rm -rf $(DESTDIR)$(versiondir)/$(GARNAME)
	@rm -rf $(DESTDIR)$(licensedir)/$(GARNAME)
	@$(MAKECOOKIE)

clean-all:
	@rm -rf $(DESTDIR)$(bindir)/mtd
	@rm -rf $(DESTDIR)$(bindir)/myth*
	@rm -rf $(DESTDIR)$(datadir)/myth*
	@rm -rf $(DESTDIR)$(includedir)/myth*
	@rm -rf $(DESTDIR)$(libdir)/libmyth*
	@rm -rf $(DESTDIR)$(libdir)/myth*
	@$(foreach dir,$(filter-out %/Makefile,$(wildcard ../../myth/* ../../myth-*/*)),$(MAKE) -C $(dir) clean ; )

myth-update:
	@$(MAKE) -C ../mythtv            myth-update-source
	@$(MAKE) -C ../mythplugins       myth-update-source
	@$(MAKE) -C ../myththemes        myth-update-source
	@$(MAKE) -C ../myththemes-addons myth-update-source
	@$(MAKE) -C ../mythtv            myth-update-patches
	@$(MAKE) -C ../mythplugins       myth-update-patches
	@$(MAKE) -C ../myththemes        myth-update-patches
	@$(MAKE) -C ../myththemes-addons myth-update-patches
