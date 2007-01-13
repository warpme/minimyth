GARNAME = pciutils
GARVERSION = 2.2.4
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
	OPT="$(CFLAGS)" \
	DESTDIR="${DESTDIR}" \
	PREFIX="${prefix}" \
	SBINDIR="${sbindir}" \
	SHAREDIR="${sharedstatedir}" \
	IDSDIR="${datadir}" \
	MANDIR="${mandir}"
INSTALL_ARGS = \
	OPT="$(CFLAGS)" \
	DESTDIR="${DESTDIR}" \
	PREFIX="${prefix}" \
	SBINDIR="${sbindir}" \
	SHAREDIR="${sharedstatedir}" \
	IDSDIR="${datadir}" \
	MANDIR="${mandir}"

include ../../gar.mk

extract-pci.ids:
	@cp -f $(DOWNLOADDIR)/pci.ids $(WORKSRC)/pci.ids
	@$(MAKECOOKIE)
