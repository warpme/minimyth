GARNAME = fftw
GARVERSION = 3.1.2
CATEGORIES = lib
MASTER_SITES = http://www.fftw.org/
DISTFILES = $(DISTNAME).tar.gz
#PATCHFILES = $(DISTNAME)-cross.patch
LICENSE = LGPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-shared \
	--enable-single \
	--with-gnu-ld \
	--with-gcc-arch=$(GARCH)

include ../../gar.mk

post-install:
	@rm -f $(DESTDIR)$(libdir)/libfftw3f.la
	@$(MAKECOOKIE)
