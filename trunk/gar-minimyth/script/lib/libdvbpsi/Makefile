GARNAME = libdvbpsi5
GARVERSION = 0.1.6
CATEGORIES = lib
MASTER_SITES = http://download.videolan.org/pub/libdvbpsi/$(GARVERSION)/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = LGPL2

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
	@rm -f $(DESTDIR)$(libdir)/libdvbpsi.la
	@$(MAKECOOKIE)
