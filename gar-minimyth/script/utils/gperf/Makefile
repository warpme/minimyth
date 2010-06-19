GARNAME = gperf
GARVERSION = 3.0.4
CATEGORIES = utils
MASTER_SITES = http://ftp.gnu.org/gnu/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES= $(DISTNAME)-ar.patch
LICENSE = GPL3

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lang/cxx

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST)

include ../../gar.mk

# gperf 3.0.4 fails to compile using the gold linker.
CFLAGS   := $(filter-out -fuse-ld=gold -fuse-linker-plugin, $(CFLAGS))
CXXFLAGS := $(filter-out -fuse-ld=gold -fuse-linker-plugin, $(CXXFLAGS))
LDFLAGS  := $(filter-out -fuse-ld=gold -fuse-linker-plugin, $(LDFLAGS))

pre-configure:
	@cd $(WORKSRC)/lib ; autoconf --verbose
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)
