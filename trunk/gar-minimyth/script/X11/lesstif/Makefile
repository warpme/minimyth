GARNAME = lesstif
GARVERSION = 0.94.4
CATEGORIES = X11
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME).patch.gar $(DISTNAME)-aclocal.patch
LICENSE =

DESCRIPTION =
define BLURB
endef

DEPENDS   = lang/c X11/X11 
ifneq ($(DESTIMG),build)
BUILDDEPS = X11/lesstif
endif

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes=$(DESTDIR)$(x11includedir) \
	--x-libraries=$(DESTDIR)$(x11libdir) \
	--with-gnu-ld
BUILD_ARGS     = \
	rootdir="$(docdir)/$(DISTNAME)"
INSTALL_ARGS   = \
	rootdir="$(docdir)/$(DISTNAME)"

CONFIGURE_ENV  = \
	man2html_cmd=$(build_DESTDIR)$(build_bindir)/$(GARNAME)-man2html

include ../../gar.mk

post-install:
	@$(if $(filter build,$(DESTIMG)),cp -f $(WORKSRC)/scripts/man2html $(DESTDIR)$(bindir)/$(GARNAME)-man2html)
	@rm -f $(DESTDIR)$(libdir)/libXm.la
	@rm -f $(DESTDIR)$(libdir)/libMrm.la
	@rm -f $(DESTDIR)$(libdir)/libUil.la
	@$(MAKECOOKIE)
