GARNAME = rxvt
GARVERSION = 2.7.9
CATEGORIES = X11
MASTER_SITES = http://linpvr.org/dnload/gar-source
DISTFILES = $(GARNAME)-$(GARVERSION).tar.gz
LICENSE =

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c X11/X11 

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) --target=$(GARTARGET) \
	--x-includes=$(DESTDIR)$(x11includedir) \
	--x-libraries=$(DESTDIR)$(x11libdir)

include ../../gar.mk
