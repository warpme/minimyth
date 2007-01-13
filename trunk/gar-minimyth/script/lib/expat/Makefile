GARNAME = expat
GARVERSION = 1.95.6
CATEGORIES = lib
MASTER_SITES = http://unc.dl.sourceforge.net/sourceforge/expat/
DISTFILES = $(GARNAME)-$(GARVERSION).tar.gz
LICENSE = MIT

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST)

INSTALL_OVERRIDE_DIRS = prefix exec_prefix bindir libdir includedir

include ../../gar.mk

post-install:
	rm -f $(DESTDIR)$(libdir)/libexpat.la
	$(MAKECOOKIE)
