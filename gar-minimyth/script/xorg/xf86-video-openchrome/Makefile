GARNAME = xf86-video-unichrome
GARVERSION = 157
CATEGORIES = xorg
MASTER_SITES = svn://svn.openchrome.org/svn/trunk/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE =

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c xorg/libdrm xorg/Mesa xorg/xorg-server xorg/xproto xorg/libXvMC xorg/xf86driproto xorg/libXft

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--cache-file=config.cache \
	--enable-dri \
	--with-gnu-ld

GAR_EXTRA_CONF += xorg/xorg/package-api.mk
include ../../gar.mk
include ../../xorg/xorg.mk

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

post-patch:
	@cd $(WORKSRC) ; autoreconf -v --install
	@$(MAKECOOKIE)

pre-configure:
	@rm -f $(WORKSRC)/config.cache
	@echo "`echo ac_cv_file_$(x11includedir)/xorg/dri.h | sed -e 's%[/.]%_%g'`=yes"       >> $(WORKSRC)/config.cache
	@echo "`echo ac_cv_file_$(x11includedir)/xorg/dristruct.h | sed -e 's%[/.]%_%g'`=yes" >> $(WORKSRC)/config.cache
	@echo "`echo ac_cv_file_$(x11includedir)/xorg/sarea.h | sed -e 's%[/.]%_%g'`=yes"     >> $(WORKSRC)/config.cache
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(x11libdir)/xorg/modules/drivers/via_drv.la
	@rm -f $(DESTDIR)$(x11libdir)/libviaXvMC.la
	@rm -f $(DESTDIR)$(x11libdir)/libviaXvMCPro.la
	@$(MAKECOOKIE)
