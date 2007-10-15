GARNAME = nss_ldap
GARVERSION = 258
CATEGORIES = system
MASTER_SITES = ftp://ftp.padl.com/pub/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-pw_override.patch $(DISTNAME)-mkhomedir.patch
LICENSE = LGPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/openldap

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-rfc2307bis \
	--with-ldap-lib=openldap \
	--with-ldap-conf-file=$(sysconfdir)/ldap.conf \
	--with-ldap-secret-file=$(sysconfdir)/ldap.secret

INSTALL_ARGS = \
	INST_UID=$(shell id -u) \
	INST_GID=$(shell id -g)

include ../../gar.mk
