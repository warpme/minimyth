GARNAME = zoneinfo
GARVERSION = 2005j
CATEGORIES = system
MASTER_SITES = ftp://elsie.nci.nih.gov/pub/
DISTFILES = tzcode$(GARVERSION).tar.gz tzdata$(GARVERSION).tar.gz
LICENSE =

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c kernel/linux

BUILD_SCRIPTS   = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = $(WORKSRC)/Makefile

INSTALL_ARGS = \
	TOPDIR=../$(DISTNAME)-install

include ../../gar.mk

extract-%:
	@mkdir -p $(WORKSRC)
	@gzip -dc $(DOWNLOADDIR)/$* | tar -xf - -C $(WORKSRC)
	@$(MAKECOOKIE)

post-install:
	@rm -rf $(DESTDIR)$(datadir)/zoneinfo
	@cp -r $(WORKDIR)/$(DISTNAME)-install/etc/zoneinfo $(DESTDIR)$(datadir)
	@$(MAKECOOKIE)
