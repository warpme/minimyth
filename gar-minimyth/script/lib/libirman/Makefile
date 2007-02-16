GARNAME = libirman
GARVERSION = 0.4.4
CATEGORIES = lib
MASTER_SITES = http://lirc.sourceforge.net/software/snapshots/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-autoconf.patch
LICENSE = GPL2/LGPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST)

include ../../gar.mk

CFLAGS := $(CFLAGS) -fPIC

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(MAKECOOKIE)

post-install:
	@cp $(WORKSRC)/test_io   $(DESTDIR)/$(bindir)
	@cp $(WORKSRC)/test_name $(DESTDIR)/$(bindir)
	@cp $(WORKSRC)/test_func $(DESTDIR)/$(bindir)
	@$(MAKECOOKIE)
