GARNAME = pciutils
GARVERSION = 2.2.3
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

BUILD_ARGS = \
	OPT="$(CFLAGS)"

BUILD_OVERRIDE_DIRS = \
	PREFIX SBINDIR SHAREDIR IDSDIR MANDIR
INSTALL_OVERRIDE_DIRS = \
	PREFIX SBINDIR SHAREDIR IDSDIR MANDIR

include ../../gar.mk

PREFIX   := $(prefix)
SBINDIR  := $(sbindir)
SHAREDIR := $(sharedstatedir)
IDSDIR   := $(datadir)
MANDIR   := $(mandir)

extract-pci.ids:
	@cp -f $(DOWNLOADDIR)/pci.ids $(WORKSRC)/pci.ids
	@$(MAKECOOKIE)
