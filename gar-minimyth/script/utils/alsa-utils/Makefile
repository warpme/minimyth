GARNAME = alsa-utils
GARVERSION = 1.0.7
CATEGORIES = utils
MASTER_SITES = ftp://ftp.alsa-project.org/pub/utils/
DISTFILES = $(GARNAME)-$(GARVERSION).tar.bz2
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/alsa-lib lib/ncurses

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-alsatest

include ../../gar.mk

xxx-post-install:
	@rm -f $(DESTDIR)$(libdir)/libasound.la
	@sed -i 's% -L$${libdir}% -L$(DESTDIR)$${libdir}%g'         $(DESTDIR)$(libdir)/pkgconfig/alsa.pc
	@sed -i 's% -I$${includedir}% -I$(DESTDIR)$${includedir}%g' $(DESTDIR)$(libdir)/pkgconfig/alsa.pc
	@$(MAKECOOKIE)
