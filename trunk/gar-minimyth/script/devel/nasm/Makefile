GARNAME = nasm
GARVERSION = 2.05
CATEGORIES = devel
MASTER_SITES  = http://www.nasm.us/pub/nasm/releasebuilds/$(GARVERSION)/
MASTER_SITES += http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = LGPL2_1

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile
                                                                                                                             
CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST)

INSTALL_ENV = INSTALLROOT="$(DESTDIR)"

include ../../gar.mk
