GARNAME = flex
GARVERSION = 2.5.4
CATEGORIES = devel
MASTER_SITES = ftp://ftp.gnu.org/non-gnu/flex/
DISTFILES = $(GARNAME)-$(GARVERSION)a.tar.gz
LICENSE = BSD

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = --build=$(GARBUILD) --host=$(GARHOST) --target=$(GARTARGET) \
	--prefix=$(prefix) \
	--exec_prefix=$(exec_prefix)

INSTALL_OVERRIDE_DIRS = bindir libdir includedir mandir

include ../../gar.mk
