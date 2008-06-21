GARNAME = pmount
GARVERSION = 0.9.13
CATEGORIES = utils
MASTER_SITES = http://www.piware.de/projects/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-umountprog.patch $(DISTNAME)-install.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c lib/sysfsutils utils/util-linux-ng
BUILDDEPS = perl/perl-XML-Parser

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-hal \
	--with-gnu-ld \
	--with-media-dir="$(rootdir)/media/" \
	--with-lock-dir="$(localstatedir)/lock/pmount" \
	--with-whitelist="$(sysconfdir)/pmount.allow" \
	--with-mount-prog="$(ebindir)/mount" \
	--with-umount-prog="$(ebindir)/umount" \
	--with-cryptsetup-prog="$(esbindir)/cryptsetup"

include ../../gar.mk

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)
