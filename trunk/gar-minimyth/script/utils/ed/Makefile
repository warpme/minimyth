GARNAME = ed
GARVERSION = 0.2
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

CONFIGURE_ARGS = --prefix=$(prefix) --exec-prefix=$(exec_prefix) --build=$(GARBUILD) --host=$(GARHOST)
BUILD_ARGS     = \
	AR="$(AR)"
INSTALL_ARGS   = \
	AR="$(AR)"

BUILD_OVERRIDE_DIRS   = prefix exec_prefix bindir infordir mandir
INSTALL_OVERRIDE_DIRS = prefix exec_prefix bindir infordir mandir

include ../../gar.mk

mandir := $(mandir)/man1
