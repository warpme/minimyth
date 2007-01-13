GARNAME = zlib
GARVERSION = 1.2.2
CATEGORIES = lib
MASTER_SITES = http://www.libpng.org/pub/png/src/
DISTFILES = $(DISTNAME).tar.gz license
PATCHFILES = $(DISTNAME)-can-2005-2096.patch
LICENSE = zlib
zlib_LICENSE_TEXT = $(WORKDIR)/license

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = \
	--prefix=$(prefix) \
	--exec_prefix=$(exec_prefix) \
     	--libdir=$(libdir) \
	--includedir=$(includedir) \
	--shared

INSTALL_OVERRIDE_DIRS = prefix exec_prefix libdir includedir mandir

include ../../gar.mk
