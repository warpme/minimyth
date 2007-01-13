GARNAME = flex
GARVERSION = 2.5.4
CATEGORIES = devel
MASTER_SITES = ftp://ftp.gnu.org/non-gnu/$(GARNAME)/
DISTFILES = $(DISTNAME)a.tar.gz
LICENSE = BSD

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = --build=$(GARBUILD) --host=$(GARHOST) \
	--prefix=$(prefix) \
	--exec_prefix=$(exec_prefix)

BUILD_OVERRIDE_DIRS   = prefix exec_prefix bindir libdir includedir mandir
INSTALL_OVERRIDE_DIRS = prefix exec_prefix bindir libdir includedir mandir

include ../../gar.mk

mandir := $(mandir)/man1
