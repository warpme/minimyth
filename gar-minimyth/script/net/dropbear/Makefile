GARNAME = dropbear
GARVERSION = 0.50
CATEGORIES = net
MASTER_SITES = http://matt.ucc.asn.au/dropbear/releases/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/zlib

CONFIGURE_SCRIPTS  = $(WORKSRC)/configure
BUILD_SCRIPTS      = $(WORKSRC)/Makefile
INSTALL_SCRIPTS    = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST)

DEFAULT_ENV   = \
	PROGRAMS="dropbear dbclient dropbearkey dropbearconvert scp"
CONFIGURE_ENV = $(DEFAULT_ENV)
BUILD_ENV     = $(DEFAULT_ENV)
INSTALL_ENV   = $(DEFAULT_ENV)

include ../../gar.mk
