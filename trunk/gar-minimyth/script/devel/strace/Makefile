GARNAME = strace
GARVERSION = 4.5.20
CATEGORIES = devel
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
#PATCHFILES = $(DISTNAME)-linux_2_6_32.patch
LICENSE = BSD_3_Clause

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c 

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST)

include ../../gar.mk

# strace 4.5.20 fails to compile with GCC 4.5.0's link time optimization.
CFLAGS  := $(filter-out -flto -fuse-linker-plugin, $(CFLAGS))
LDFLAGS := $(filter-out -flto -fuse-linker-plugin, $(LDFLAGS))
