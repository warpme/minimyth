GARNAME = fvwm
#GARVERSION = 2.5.12
GARVERSION = 2.4.19
CATEGORIES = X11
MASTER_SITES = ftp://ftp.fvwm.org/pub/fvwm/version-2/
DISTFILES = $(GARNAME)-$(GARVERSION).tar.bz2
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS   = lang/c X11/X11

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes=$(DESTDIR)$(x11includedir) \
	--x-libraries=$(DESTDIR)$(x11libdir) \
	--disable-sm \
	--disable-shape \
	--disable-shm \
	--disable-freetypetest \
	--disable-fontconfigtest \
	--disable-xfttest \
	--disable-perllib \
	--disable-gtk \
	--disable-gtktest \
	--disable-imlibtest

include ../../gar.mk

post-extract:
	@sed -i 's%\("$$cross_compiling" *= *\)yes%\1gar%' $(WORKSRC)/configure
	@$(MAKECOOKIE)
