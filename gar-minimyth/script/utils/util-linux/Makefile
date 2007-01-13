GARNAME = util-linux
GARVERSION = 2.12r
CATEGORIES = utils
MASTER_SITES = ftp://ftp.kernel.org/pub/linux/utils/util-linux/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME).patch.gar $(DISTNAME)-cramfs.patch
LICENSE = BSD/GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/ncurses lib/zlib utils/procps disk/e2fsprogs

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = KERNEL_ARCH=$(GARCH_FAMILY)
BUILD_ARGS     = KERNEL_ARCH=$(GARCH_FAMILY)
INSTALL_ARGS   = KERNEL_ARCH=$(GARCH_FAMILY)

BUILD_OVERRIDE_DIRS   = \
	DEV_DIR ETC_DIR SBIN_DIR USRSBIN_DIR USRLIB_DIR USRBIN_DIR USRGAMES_DIR USRSHAREMISC_DIR LOCALE_DIR BIN_DIR VAR_PATH LOG_DIR MAN_DIR INFO_DIR MOREHELP_DIR
INSTALL_OVERRIDE_DIRS = \
	DEVDIR  ETCDIR  SBINDIR  USRSBINDIR  USRLIBDIR  USRBINDIR  USRGAMESDIR  USRSHAREMISCDIR  LOCALEDIR  BINDIR  VARPATH  LOGDIR  MANDIR  INFODIR  MOREHELPDIR

include ../../gar.mk

DEV_DIR          := $(rootdir)/dev
ETC_DIR          := $(sysconfdir)
SBIN_DIR         := $(esbindir)
USRSBIN_DIR      := $(sbindir)
USRLIB_DIR       := $(libdir)
USRBIN_DIR       := $(bindir)
USRGAMES_DIR     := $(bindir)
USRSHAREMISC_DIR := $(sharedstatedir)
LOCALE_DIR       := $(sharedstatedir)/locale
BIN_DIR          := $(ebindir)
VAR_PATH         := $(localstatedir)
LOG_DIR          := $(localstatedir)/log
MAN_DIR          := $(mandir)
INFO_DIR         := $(infodir)
MOREHELP_DIR     := $(docdir)

DEVDIR           := $(DEV_DIR)
ETCDIR           := $(ETC_DIR)
SBINDIR          := $(SBIN_DIR)
USRSBINDIR       := $(USRSBIN_DIR)
USRLIBDIR        := $(USRLIB_DIR)
USRBINDIR        := $(USRBIN_DIR)
USRGAMESDIR      := $(USRGAMES_DIR)
USRSHAREMISCDIR  := $(USRSHAREMISC_DIR)
LOCALEDIR        := $(LOCALE_DIR)
BINDIR           := $(BIN_DIR)
VARPATH          := $(VAR_PATH)
LOGDIR           := $(LOG_DIR)
MANDIR           := $(MAN_DIR)
INFODIR          := $(INFO_DIR)
MOREHELPDIR      := $(MOREHELP_DIR)
