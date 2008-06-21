GARNAME = sysfsutils
GARVERSION = 2.1.0
CATEGORIES = lib
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/linux-diag/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = GPL2/LGPL2_1

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--with-gnu-ld

include ../../gar.mk

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	rm -f $(DESTDIR)$(libdir)/libsysfs.la
	@$(MAKECOOKIE)
