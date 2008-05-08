GARNAME = a52dec
GARVERSION = 0.7.4
CATEGORIES = lib
MASTER_SITES = http://liba52.sourceforge.net/files/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-fpic.patch
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
	--disable-static \
	--disable-double \
	--disable-djbfft \
	--disable-oss \
	--disable-solaris-audio \
	--disable-al-audio \
	--disable-win \
	--disable-warnings \
	--disable-gprof \
	--with-gnu-ld

include ../../gar.mk

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/liba52.la
	@$(MAKECOOKIE)
