GARNAME = myththemes-blue-abstract-wide
GARVERSION = 2010.05.26
CATEGORIES = $(CATEGORY)
#MASTER_SITES = ftp://miroku.no-ip.com/
DISTFILES = blue-abstract-wide.$(GARVERSION).tar.bz2
PATCHFILES  =
LICENSE =

DESCRIPTION = 
define BLURB
endef

xDEPENDS = \
	lang/cxx \
	$(CATEGORY)/mythtv

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

WORKSRC = $(WORKDIR)/blue-abstract-wide

INSTALL_SCRIPTS = custom

GAR_EXTRA_CONF += $(CATEGORY)/mythtv/package-api.mk
include ../../gar.mk

install-custom:
	@rm -f $(DESTIDR)$(datadir)/mythtv/themes/blue-abstract-wide
	@cp -r $(WORKSRC) $(DESTDIR)$(datadir)/mythtv/themes/blue-abstract-wide
	@$(MAKECOOKIE)
