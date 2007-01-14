GARNAME = bash
GARVERSION = 3.1
CATEGORIES = utils
MASTER_SITES  = ftp://ftp.gnu.org/gnu/$(GARNAME)/
MASTER_SITES += ftp://ftp.gnu.org/gnu/$(GARNAME)/$(DISTNAME)-patches/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES  = $(GARNAME)31-001
PATCHFILES += $(GARNAME)31-002
PATCHFILES += $(GARNAME)31-003
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

PATCHDIRLEVEL = 0

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-minimal-config \
	--with-gnu-ld

include ../../gar.mk

patch-%: normal-patch-%
	@$(MAKECOOKIE)

post-install:
	@ln -fs bash $(DESTDIR)$(bindir)/sh
	@$(MAKECOOKIE)
