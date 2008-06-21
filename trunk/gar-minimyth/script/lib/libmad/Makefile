GARNAME = libmad
GARVERSION = 0.15.1b
CATEGORIES = lib
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/mad/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-mad_pc.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-debugging \
	--with-gnu-ld

include ../../gar.mk

pre-configure:
	@touch $(WORKSRC)/AUTHORS
	@touch $(WORKSRC)/ChangeLog
	@touch $(WORKSRC)/NEWS
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libmad.la
	@$(MAKECOOKIE)
