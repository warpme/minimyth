GARNAME = unichrome
GARVERSION = 20050815
CATEGORIES = X11
#MASTER_SITES = http://www.openchrome.org/snapshots/unichrome/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-imakefile.patch
LICENSE =

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c X11/X11

CONFIGURE_SCRIPTS = unichrome libxvmc
BUILD_SCRIPTS     = $(WORKSRC)/unichrome/Makefile $(WORKSRC)/libxvmc/Makefile
INSTALL_SCRIPTS   = unichrome libxvmc

GAR_EXTRA_CONF += X11/X11/package-api.mk
include ../../gar.mk

configure-unichrome:
	@cd $(WORKSRC)/unichrome ; \
		$(GARHOST)-imake -I$(DESTDIR)$(X11_SOURCEDIR)/config/cf -DTOPDIR=$(DESTDIR)$(X11_SOURCEDIR) -DCURDIR=.
	@$(MAKECOOKIE)

configure-libxvmc:
	@cd $(WORKSRC)/libxvmc ; \
		$(GARHOST)-imake -I$(DESTDIR)$(X11_SOURCEDIR)/config/cf -DTOPDIR=$(DESTDIR)$(X11_SOURCEDIR) -DCURDIR=.
	@$(MAKECOOKIE)

install-unichrome:
	@mkdir -p $(DESTDIR)$(x11libdir)/modules/drivers
	@cp -df $(WORKSRC)/unichrome/via_drv.o $(DESTDIR)$(x11libdir)/modules/drivers/via_drv.o
	@$(MAKECOOKIE)

install-libxvmc:
	@mkdir -p $(DESTDIR)$(x11libdir)
	@cp -df $(WORKSRC)/libxvmc/libviaXvMC.so      $(DESTDIR)$(x11libdir)
	@cp -df $(WORKSRC)/libxvmc/libviaXvMC.so.*    $(DESTDIR)$(x11libdir)
	@cp -df $(WORKSRC)/libxvmc/libviaXvMCPro.so   $(DESTDIR)$(x11libdir)
	@cp -df $(WORKSRC)/libxvmc/libviaXvMCPro.so.* $(DESTDIR)$(x11libdir)
	@cp -f  $(WORKSRC)/libxvmc/vldXvMC.h          $(DESTDIR)$(x11includedir)/X11/extensions
	@$(MAKECOOKIE)
