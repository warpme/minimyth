GARNAME = unichrome
GARVERSION = 153
CATEGORIES = X11
MASTER_SITES = svn://svn.openchrome.org/svn/trunk/
DISTFILES = $(DISTNAME).tar.bz2
#PATCHFILES = $(DISTNAME)-imakefile.patch
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

svn//%/$(DISTNAME).tar.bz2:
	@cd $(PARTIALDIR); rm -rf $(GARNAME)
	@cd $(PARTIALDIR); svn co -r $(GARVERSION) http://$* $(GARNAME)
	@cd $(PARTIALDIR); rm -rf $(DISTNAME)
	@cd $(PARTIALDIR); mv $(GARNAME) $(DISTNAME)
	@cd $(PARTIALDIR); tar -jcf $(DISTNAME).tar.bz2 $(DISTNAME)
	@cd $(PARTIALDIR); rm -rf $(DISTNAME)
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

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
	@cp -df $(WORKSRC)/unichrome/via_drv.so $(DESTDIR)$(x11libdir)/modules/drivers/via_drv.so
	@$(MAKECOOKIE)

install-libxvmc:
	@mkdir -p $(DESTDIR)$(x11libdir)
	@cp -df $(WORKSRC)/libxvmc/libviaXvMC.so      $(DESTDIR)$(x11libdir)
	@cp -df $(WORKSRC)/libxvmc/libviaXvMC.so.*    $(DESTDIR)$(x11libdir)
	@cp -df $(WORKSRC)/libxvmc/libviaXvMCPro.so   $(DESTDIR)$(x11libdir)
	@cp -df $(WORKSRC)/libxvmc/libviaXvMCPro.so.* $(DESTDIR)$(x11libdir)
	@cp -f  $(WORKSRC)/libxvmc/vldXvMC.h          $(DESTDIR)$(x11includedir)/X11/extensions
	@$(MAKECOOKIE)
