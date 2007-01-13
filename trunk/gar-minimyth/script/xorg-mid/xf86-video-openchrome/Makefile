GARNAME = xf86-video-openchrome
GARVERSION = 206
CATEGORIES = xorg-mid
MASTER_SITES = svn://svn.openchrome.org/svn/trunk/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE =

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c xorg-mid/X11

CONFIGURE_SCRIPTS = unichrome libxvmc
BUILD_SCRIPTS     = $(WORKSRC)/unichrome/Makefile $(WORKSRC)/libxvmc/Makefile
INSTALL_SCRIPTS   = unichrome libxvmc

GAR_EXTRA_CONF += xorg-mid/X11/package-api.mk
include ../../gar.mk

svn//%/$(DISTNAME).tar.bz2:
	@$(call FETCH_SVN, http://$*, $(GARVERSION), $(DISTNAME))
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
	@mkdir -p $(DESTDIR)$(libdir)/xorg/modules/drivers
	@cp -df $(WORKSRC)/unichrome/via_drv.o $(DESTDIR)$(libdir)/xorg/modules/drivers/via_drv.o
	@$(MAKECOOKIE)

install-libxvmc:
	@mkdir -p $(DESTDIR)$(libdir)
	@cp -df $(WORKSRC)/libxvmc/libviaXvMC.so      $(DESTDIR)$(libdir)
	@cp -df $(WORKSRC)/libxvmc/libviaXvMC.so.*    $(DESTDIR)$(libdir)
	@cp -df $(WORKSRC)/libxvmc/libviaXvMCPro.so   $(DESTDIR)$(libdir)
	@cp -df $(WORKSRC)/libxvmc/libviaXvMCPro.so.* $(DESTDIR)$(libdir)
	@cp -f  $(WORKSRC)/libxvmc/vldXvMC.h          $(DESTDIR)$(includedir)/X11/extensions
	@$(MAKECOOKIE)
