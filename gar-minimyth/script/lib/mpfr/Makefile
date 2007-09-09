GARNAME = mpfr
GARVERSION = 2.3.0
CATEGORIES = lib
MASTER_SITES = http://www.mpfr.org/mpfr-current/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-patches.patch
LICENSE = GPL2/LGPL2_1

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/gmp

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--with-gmp-include=$(DESTDIR)$(includedir) \
	--with-gmp-lib=$(DESTDIR)$(libdir) \
	--with-gnu-ld

include ../../gar.mk

post-install:
	@rm -f $(DESTDIR)$(libdir)/libmpfr.la
	@$(MAKECOOKIE)
