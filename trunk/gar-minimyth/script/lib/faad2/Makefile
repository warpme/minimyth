GARNAME = faad2
GARVERSION = 2.7
CATEGORIES = lib
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/faac/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-mp4ff_shared.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

#WORKSRC = $(WORKDIR)/$(GARNAME)

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-shared \
	--disable-static \
	--with-gnu-ld

include ../../gar.mk

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libfaad.la
	@rm -f $(DESTDIR)$(libdir)/libmp4ff.a
	@rm -f $(DESTDIR)$(libdir)/libmp4ff.la
	@$(MAKECOOKIE)
