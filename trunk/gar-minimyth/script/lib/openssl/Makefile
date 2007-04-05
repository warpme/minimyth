GARNAME = openssl
GARVERSION = 0.9.8e
CATEGORIES = lib
MASTER_SITES = http://www.openssl.org/source/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME).patch.gar
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/LICENSE

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/Configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = \
	--prefix=$(prefix) \
	--install_prefix=$(DESTDIR) \
	shared \
	no-krb5 \
	zlib-dynamic \
	$(if $(filter i386,  $(GARCH_FAMILY)),linux-elf) \
	$(if $(filter x86_64,$(GARCH_FAMILY)),linux-x86_64)

BUILD_ARGS = \
	CC="$(CC)" \
	AR="$(AR) r" \
	RANLIB="$(RANLIB)"

include ../../gar.mk

configure-%/Configure: 
	@echo " ==> Running Configure in $*"
	@cd $* && $(CONFIGURE_ENV) ./Configure $(CONFIGURE_ARGS)
	@$(MAKECOOKIE)

