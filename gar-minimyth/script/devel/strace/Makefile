GARNAME = strace
GARVERSION = 4.5.14
CATEGORIES = devel
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-subcall400.patch $(DISTNAME)-glibc_2.5.patch $(DISTNAME)-linux_2.6.18.patch
LICENSE = BSD

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c 

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST)

include ../../gar.mk
