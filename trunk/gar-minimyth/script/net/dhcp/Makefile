GARNAME = dhcp
GARVERSION =  4.0.0
CATEGORIES = net
MASTER_SITES = http://ftp.isc.org/isc/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-next_server.patch
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/LICENSE

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-dhcpv6

CONFIGURE_ENV = \
	ac_cv_file__dev_random=yes

include ../../gar.mk
