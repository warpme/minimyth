GARNAME = pkg-config
GARVERSION = 0.23
CATEGORIES = devel
MASTER_SITES = http://pkgconfig.freedesktop.org/releases/
DISTFILES = $(DISTNAME).tar.gz 
PATCHFILES = $(DISTNAME)-sysroot.patch $(DISTNAME)-m4_pattern_allow.patch
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

include ../../gar.mk

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC),configure)
	@$(MAKECOOKIE)
