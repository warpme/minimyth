GARNAME = libsndfile
GARVERSION = 1.0.17
CATEGORIES = lib
MASTER_SITES = http://www.mega-nerd.com/libsndfile/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = LGPL2_1

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/alsa-lib

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-sqlite \
	--disable-flac \
	--with-gnu-ld

include ../../gar.mk

post-install:
	@rm -f $(DESTDIR)$(libdir)/libsndfile.la
	@$(call CREATE_PKG_CONFIG_UNINSTALLED,$(libdir)/pkgconfig,sndfile)
	@$(MAKECOOKIE)
