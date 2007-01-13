GARNAME = lsdvd
GARVERSION = 0.16
CATEGORIES = utils
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/acidrip/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-man.patch
LICENSE =

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/libdvdread

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST)

include ../../gar.mk

x-CFLAGS := $(CFLAGS) -ldl

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(MAKECOOKIE)
