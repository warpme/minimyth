GARNAME = ntp
GARVERSION = 4.2.0
CATEGORIES = net
MASTER_SITES = http://www.eecis.udel.edu/~$(GARNAME)/$(GARNAME)_spool/$(GARNAME)4/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-gcc4.patch
LICENSE =

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-all-clocks \
	--without-crypto
	
include ../../gar.mk
