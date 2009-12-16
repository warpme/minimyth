GARNAME = lircudevd
GARVERSION = 0.0.0
CATEGORIES = system
DISTFILES = $(DISTNAME)
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c system/udev

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--with-udev-dir=$(elibdir)/udev

include ../../gar.mk

CFLAGS += -ggdb

$(DOWNLOADDIR)/$(DISTNAME):
	@mkdir -p $(DOWNLOADDIR)
	@rm -f $(DISTNAME)
	@cp -r files/$(DISTNAME) $(DOWNLOADDIR)/$(DISTNAME)
	@$(MAKECOOKIE)

checksum-$(DISTNAME):
	@$(MAKECOOKIE)

extract-$(DISTNAME):
	@mkdir -p $(WORKDIR)
	@rm -rf $(WORKSRC)
	@cp -r $(DOWNLOADDIR)/$(DISTNAME) $(WORKDIR)
	@$(MAKECOOKIE)

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)
