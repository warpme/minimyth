GARNAME = module-init-tools
GARVERSION = 3.7
CATEGORIES = utils
MASTER_SITES = http://www.kernel.org/pub/linux/utils/kernel/module-init-tools/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST)

CONFIGURE_ENV = \
	DOCBOOKTOMAN=true

include ../../gar.mk

bindir  := $(ebindir)
sbindir := $(esbindir)
libdir  := $(elibdir)
