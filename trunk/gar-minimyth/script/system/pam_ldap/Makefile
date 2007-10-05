GARNAME = pam_ldap
GARVERSION = 184
CATEGORIES = system
MASTER_SITES = ftp://ftp.padl.com/pub/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME).patch
LICENSE = LGPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/openldap system/pam

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-ssl \
	--with-ldap-lib=openldap \
	--with-ldap-conf-file=$(sysconfdir)/ldap.conf \
	--with-ldap-secret-file=$(sysconfdir)/ldap.secret

include ../../gar.mk

libdir := $(elibdir)
