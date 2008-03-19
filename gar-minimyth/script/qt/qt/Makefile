GARNAME = qt
GARVERSION = $(mm_QT_VERSION)
CATEGORIES = qt
LICENSE =

DESCRIPTION = 
define BLURB
endef

DEPENDS = qt/qt$(mm_QT_VERSION)

include ../../gar.mk

post-install:
	@rm -rf $(DESTDIR)$(versiondir)/$(GARNAME)
	@rm -rf $(DESTDIR)$(licensedir)/$(GARNAME)
	@$(MAKECOOKIE)
