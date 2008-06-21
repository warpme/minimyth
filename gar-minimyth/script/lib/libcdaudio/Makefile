GARNAME = libcdaudio
GARVERSION = 0.99.12p2
CATEGORIES = lib
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-DESTDIR.patch.gar
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-threads \
	--with-gnu-ld

include ../../gar.mk

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libcdaudio.la
	@$(MAKECOOKIE)
