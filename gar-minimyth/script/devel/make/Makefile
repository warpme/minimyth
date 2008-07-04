GARNAME = make
GARVERSION = 3.81
CATEGORIES = devel
MASTER_SITES = ftp://ftp.gnu.org/gnu/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES  = $(DISTNAME)-library_search.patch
ifneq ("$(DESTIMG)+$(CROSSIMG)","build+build")
PATCHFILES += $(DISTNAME)-perl.patch.gar
endef
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-rpath

include ../../gar.mk
