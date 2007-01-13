GARNAME = powernowd
GARVERSION = 0.96
CATEGORIES = system
MASTER_SITES = http://www.deater.net/john/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

BUILD_SCRIPTS   = custom
INSTALL_SCRIPTS = custom

include ../../gar.mk

build-custom:
	@cd $(WORKSRC) ; $(CC) $(CFLAGS) -o powernowd powernowd.c
	@$(MAKECOOKIE)

install-custom:
	@cd $(WORKSRC) ; install -m 755 -D powernowd $(DESTDIR)$(sbindir)/powernowd
	@$(MAKECOOKIE)
