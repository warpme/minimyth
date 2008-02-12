GARNAME = pciutils
GARVERSION = 2.2.10
CATEGORIES = utils
MASTER_SITES = ftp://ftp.kernel.org/pub/software/utils/pciutils/
DISTFILES = $(DISTNAME).tar.gz pci.ids
PATCHFILES = $(DISTNAME).patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

BUILD_SCRIPTS   = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = $(WORKSRC)/Makefile

BUILD_ARGS   = \
	AR="$(AR)" \
	RANLIB="$(RANLIB)" \
	OPT="$(CFLAGS)" \
	DESTDIR="${DESTDIR}" \
	PREFIX="${prefix}" \
	SBINDIR="${sbindir}" \
	SHAREDIR="${sharedstatedir}" \
	IDSDIR="${datadir}" \
	MANDIR="${mandir}" \
	HOST="$(GARHOST)" \
	RELEASE="$(LINUX_VERSION)" \
	ZLIB="no"
INSTALL_ARGS = \
	AR="$(AR)" \
	RANLIB="$(RANLIB)" \
	OPT="$(CFLAGS)" \
	DESTDIR="${DESTDIR}" \
	PREFIX="${prefix}" \
	SBINDIR="${sbindir}" \
	SHAREDIR="${sharedstatedir}" \
	IDSDIR="${datadir}" \
	MANDIR="${mandir}" \
	HOST="$(GARHOST)" \
	RELEASE="$(LINUX_VERSION)" \
	ZLIB="no"

BUILD_ENV = \

GAR_EXTRA_CONF += kernel-$(mm_KERNEL_VERSION)/linux/package-api.mk
include ../../gar.mk

extract-pci.ids:
	@cp -f $(DOWNLOADDIR)/pci.ids $(WORKSRC)/pci.ids
	@$(MAKECOOKIE)
