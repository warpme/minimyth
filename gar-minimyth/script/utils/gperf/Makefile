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

# Fails to compile using the gold linker link time optimization plugin.
CFLAGS   := $(filter-out -fuse-linker-plugin, $(CFLAGS))
CXXFLAGS := $(filter-out -fuse-linker-plugin, $(CXXFLAGS))
LDFLAGS  := $(filter-out -fuse-linker-plugin, $(LDFLAGS))

pre-configure:
	@cd $(WORKSRC)/lib ; autoconf --verbose
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)
