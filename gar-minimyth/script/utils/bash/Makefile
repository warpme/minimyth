GARNAME = bash
GARVERSION = 3.2
CATEGORIES = utils
MASTER_SITES = ftp://ftp.gnu.org/gnu/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-minimal-config \
	--with-gnu-ld

include ../../gar.mk

post-install:
	@ln -fs bash $(DESTDIR)$(bindir)/sh
	@$(MAKECOOKIE)
