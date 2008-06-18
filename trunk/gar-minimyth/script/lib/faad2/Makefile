GARNAME = faad2
GARVERSION = 2.6.1
CATEGORIES = lib
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/faac/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-libtool_2.2.x.patch $(DISTNAME)-mp4ff.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

WORKSRC = $(WORKDIR)/$(GARNAME)

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--with-gnu-ld

include ../../gar.mk

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libfaad.la
	@rm -f $(DESTDIR)$(libdir)/libmp4ff.la
	@$(MAKECOOKIE)
