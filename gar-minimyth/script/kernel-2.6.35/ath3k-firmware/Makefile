GARNAME = ath3k
GARVERSION = 1
CATEGORIES = kernel-2.6.35
MASTER_SITES =
DISTFILES = $(DISTNAME).fw LICENCE.atheros_firmware
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/LICENSE

DESCRIPTION =
define BLURB
endef

INSTALL_SCRIPTS = custom

include ../../gar.mk

extract-$(DISTNAME).fw:
	@mkdir -p $(WORKSRC)
	@cp $(DOWNLOADDIR)/$(DISTNAME).fw $(WORKSRC)/$(DISTNAME).fw
	@$(MAKECOOKIE)

extract-LICENCE.atheros_firmware:
	@mkdir -p $(WORKSRC)
	@cp $(DOWNLOADDIR)/LICENCE.atheros_firmware $(WORKSRC)/LICENSE
	@$(MAKECOOKIE)

install-custom:
	@rm -rf $(DESTDIR)$(elibdir)/firmware/$(DISTNAME).fw
	@mkdir -p $(DESTDIR)$(elibdir)/firmware/
	@cp $(WORKSRC)/$(DISTNAME).fw $(DESTDIR)$(elibdir)/firmware/
	@$(MAKECOOKIE)
