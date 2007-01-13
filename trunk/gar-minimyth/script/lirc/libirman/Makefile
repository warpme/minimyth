GARNAME = libirman
GARVERSION = 0.4.3
CATEGORIES = lirc
MASTER_SITES = http://lirc.sourceforge.net/software/snapshots/
DISTFILES = $(GARNAME)-$(GARVERSION).tar.gz
LICENSE = GPL2/LGPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) --target=$(GARTARGET)

BUILD_OVERRIDE_DIRS   = prefix exec_prefix bindir sbindir libdir sysconfdir includedir
INSTALL_OVERRIDE_DIRS = prefix exec_prefix bindir sbindir libdir sysconfdir includedir

GAR_EXTRA_CONF += kernel/linux/package-api.mk
include ../../gar.mk

post-install:
	@cp $(WORKSRC)/test_io   $(DESTDIR)/$(bindir)
	@cp $(WORKSRC)/test_name $(DESTDIR)/$(bindir)
	@cp $(WORKSRC)/test_func $(DESTDIR)/$(bindir)
	@$(MAKECOOKIE)
