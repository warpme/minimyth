GARNAME = module-init-tools
GARVERSION = 3.5
CATEGORIES = utils
MASTER_SITES = http://www.kernel.org/pub/linux/utils/kernel/module-init-tools/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-no_man.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST)

include ../../gar.mk

bindir  := $(ebindir)
sbindir := $(esbindir)
libdir  := $(elibdir)
