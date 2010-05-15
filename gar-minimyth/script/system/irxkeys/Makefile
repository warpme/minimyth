GARNAME = irxkeys
GARVERSION = 1.0
CATEGORIES = system
MASTER_SITES = http://frodo.dyn.gno.org/~brettk/download/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-fixes.patch
LICENSE =

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c system/lirc xorg/xorg

BUILD_SCRIPTS   = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = custom

BUILD_ARGS = \
	LDFLAGS="$(LDFLAGS)"

include ../../gar.mk

LDFLAGS := -lX11 -lXtst -llirc_client $(LDFLAGS)

install-custom:
	@mkdir -p $(DESTDIR)$(bindir)
	@cp -f $(WORKSRC)/irxkeys $(DESTDIR)$(bindir)/irxkeys
	@$(MAKECOOKIE)
