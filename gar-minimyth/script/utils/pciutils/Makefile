GARNAME = pciutils
GARVERSION = 3.0.2
CATEGORIES = utils
MASTER_SITES = ftp://ftp.kernel.org/pub/software/utils/pciutils/
DISTFILES = $(DISTNAME).tar.bz2 pci.ids
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

BUILD_SCRIPTS   = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = $(WORKSRC)/Makefile

BUILD_ARGS   = \
	OPT="$(CFLAGS)" \
	HOST="$(GARCH_FAMILY)-dummy-linux" \
	RELEASE="$(LINUX_VERSION)" \
	ZLIB="no" \
	DNS="no" \
	SHARED="yes" \
	PREFIX="$(prefix)" \
	SBINDIR="$(sbindir)" \
	SHAREDIR="$(datadir)" \
	MANDIR="$(mandir)" \
	INCDIR="$(includedir)" \
	LIBDIR="$(libdir)" \
	STRIP="" \
	AR="$(AR)" \
	RANLIB="$(RANLIB)"
INSTALL_ARGS = \
	OPT="$(CFLAGS)" \
	HOST="$(GARCH_FAMILY)-dummy-linux" \
	RELEASE="$(LINUX_VERSION)" \
	ZLIB="no" \
	DNS="no" \
	SHARED="yes" \
	PREFIX="$(prefix)" \
	SBINDIR="$(sbindir)" \
	SHAREDIR="$(datadir)" \
	MANDIR="$(mandir)" \
	INCDIR="$(includedir)" \
	LIBDIR="$(libdir)" \
	STRIP="" \
	AR="$(AR)" \
	RANLIB="$(RANLIB)"

GAR_EXTRA_CONF += kernel-$(mm_KERNEL_VERSION)/linux/package-api.mk
include ../../gar.mk

extract-pci.ids:
	@cp -f $(DOWNLOADDIR)/pci.ids $(WORKSRC)/pci.ids
	@$(MAKECOOKIE)
