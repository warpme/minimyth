GARNAME = libXvMCW
GARVERSION = 0.9.3
CATEGORIES = xorg-mid
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/unichrome/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-configure.patch
LICENSE =

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c xorg-mid/X11

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes=$(DESTDIR)$(includedir) \
	--x-libraries=$(DESTDIR)$(libdir) \
	--with-x \
	--with-gnu-ld \
	--with-config-path=$(shell echo '$(sysconfdir)/X11' | sed 's%/[/]*%/%g')
BUILD_ARGS     =
INSTALL_ARGS   = \
	DESTDIR="" \
	xconfigdir="$(DESTDIR)$(sysconfdir)/X11"

include ../../gar.mk

post-install:
	@rm -f $(DESTDIR)$(libdir)/libXvMCW.la
	@$(MAKECOOKIE)
