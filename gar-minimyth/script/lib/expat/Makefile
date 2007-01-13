GARNAME = expat
GARVERSION = 1.95.8
CATEGORIES = lib
MASTER_SITES = http://unc.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = MIT

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--with-gnu-ld

INSTALL_OVERRIDE_DIRS = prefix exec_prefix bindir libdir includedir man1dir

include ../../gar.mk

man1dir := $(mandir)/man1

post-install:
	rm -f $(DESTDIR)$(libdir)/libexpat.la
	$(MAKECOOKIE)
