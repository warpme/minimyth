GARNAME = lesstif
GARVERSION = 0.94.4
CATEGORIES = X11
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME).patch.gar
LICENSE =

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c X11/X11 

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes=$(DESTDIR)$(x11includedir) \
	--x-libraries=$(DESTDIR)$(x11libdir) \
	--with-gnu-ld

include ../../gar.mk

post-install:
	@rm -f $(DESTDIR)$(libdir)/libXm.la
	@rm -f $(DESTDIR)$(libdir)/libMrm.la
	@rm -f $(DESTDIR)$(libdir)/libUil.la
	@$(MAKECOOKIE)
