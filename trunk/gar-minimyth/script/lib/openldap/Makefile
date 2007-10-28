GARNAME = openldap
GARVERSION = 2.3.39
CATEGORIES = lib
MASTER_SITES = ftp://ftp.openldap.org/pub/OpenLDAP/openldap-release/
DISTFILES = $(DISTNAME).tgz
PATCHFILES = $(DISTNAME)-disable_install_strip.patch
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/LICENSE

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/openssl

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--cache-file=config.cache \
	--disable-slapd \
	--without-cyrus-sasl \
	--with-yielding-select

CONFIGURE_ENV = \
	ac_cv_func_memcmp_working='yes'

include ../../gar.mk

post-install:
	@rm -f $(DESTDIR)$(libdir)/liblber.la
	@rm -f $(DESTDIR)$(libdir)/libldap.la
	@rm -f $(DESTDIR)$(libdir)/libldap_r.la
	@$(MAKECOOKIE)
