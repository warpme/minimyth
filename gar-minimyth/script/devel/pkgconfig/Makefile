GARNAME = pkgconfig
GARVERSION = 0.15.0
CATEGORIES = devel
MASTER_SITES = http://www.freedesktop.org/software/pkgconfig/releases/
DISTFILES = $(GARNAME)-$(GARVERSION).tar.gz 
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) --target=$(GARTARGET) \
	--x-includes=$(DESTDIR)$(x11includedir) \
	--x-libraries=$(DESTDIR)$(x11libdir)

include ../../gar.mk
