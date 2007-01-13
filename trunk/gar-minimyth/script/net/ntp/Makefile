GARNAME = ntp
GARVERSION = 4.2.0
CATEGORIES = net
MASTER_SITES = http://www.eecis.udel.edu/~ntp/ntp_spool/ntp4/
DISTFILES = $(GARNAME)-$(GARVERSION).tar.gz
LICENSE =

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--without-crypto
	
include ../../gar.mk
