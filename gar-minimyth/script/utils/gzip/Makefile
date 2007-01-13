GARNAME = gzip
GARVERSION = 1.2.4a
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
	--with-gnu-ld

BUILD_ARGS   = \
	ASCPP="$(CPP) -DNO_UNDERLINE" \
	manext=1
INSTALL_ARGS = \
	ASCPP="$(CPP) -DNO_UNDERLINE" \
	manext=1

BUILD_OVERRIDE_DIRS   = prefix exec_prefix bindir scriptdir datadir libdir infodir mandir
INSTALL_OVERRIDE_DIRS = prefix exec_prefix bindir scriptdir datadir libdir infodir mandir

include ../../gar.mk

mandir    := $(mandir)/man1
scriptdir := $(bindir)
