GARNAME = c++
GARVERSION = none
CATEGORIES = lang

DESCRIPTION =
define BLURB
endef

DEPENDS   = lang/c lib/libstdc++
BUILDDEPS = lang/c++

include ../../gar.mk

$(DESTIMG)_NODEPEND += lang/c++
export $(DESTIMG)_NODEPEND

post-install:
	@rm -rf $(DESTDIR)$(versiondir)/$(GARNAME)
	@rm -rf $(DESTDIR)$(licensedir)/$(GARNAME)
	@$(MAKECOOKIE)
