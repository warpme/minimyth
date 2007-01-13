GARNAME = fftw
GARVERSION = 2.1.5
CATEGORIES = lib
MASTER_SITES = http://www.fftw.org/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = LGPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-fortran \
	--enable-i386-hacks \
	--with-gnu-ld

include ../../gar.mk

post-install:
	@rm -f $(DESTDIR)$(libdir)/libfftw.la
	@rm -f $(DESTDIR)$(libdir)/librfftw.la
	@$(MAKECOOKIE)
