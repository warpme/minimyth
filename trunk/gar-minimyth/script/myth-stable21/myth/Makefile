GARNAME = myth
GARVERSION = 0.21
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

mythtv-fixes-patch-all:
	@cd ../mythtv                                  ; \
		$(MAKE) clean                          ; \
		svn delete files/myth*-*-fixes-*.patch ; \
		$(MAKE) mythtv-fixes-patch             ; \
		svn add files/myth*-*fixes-*.patch     ; \
		$(MAKE) clean
	@cd ../mythplugins                             ; \
		$(MAKE) clean                          ; \
		svn delete files/myth*-*-fixes-*.patch ; \
		$(MAKE) mythtv-fixes-patch             ; \
		svn add files/myth*-*fixes-*.patch     ; \
		$(MAKE) clean
	@cd ../myththemes                              ; \
		$(MAKE) clean                          ; \
		svn delete files/myth*-*-fixes-*.patch ; \
		$(MAKE) mythtv-fixes-patch             ; \
		svn add files/myth*-*fixes-*.patch     ; \
		$(MAKE) clean
