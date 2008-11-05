GARNAME = bison
GARVERSION = 2.4
CATEGORIES = devel
MASTER_SITES = ftp://ftp.gnu.org/gnu/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-perl.patch.gar
LICENSE = GPL3

DESCRIPTION =
define BLURB
endef

DEPENDS   = lang/c
BUILDDEPS = utils/m4

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-rpath \
	--with-gnu-ld

include ../../gar.mk
