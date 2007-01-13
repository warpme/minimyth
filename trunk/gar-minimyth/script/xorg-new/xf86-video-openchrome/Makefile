GARNAME = xf86-video-openchrome
GARVERSION = 204
CATEGORIES = xorg-new
MASTER_SITES = svn://svn.openchrome.org/svn/trunk/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE =

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c xorg-new/libdrm xorg-new/Mesa xorg-new/xorg-server xorg-new/xproto xorg-new/libXvMC xorg-new/xf86driproto xorg-new/libXft

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--cache-file=config.cache \
	--enable-dri \
	--with-gnu-ld

include ../../gar.mk

svn//%/$(DISTNAME).tar.bz2:
	@$(call FETCH_SVN, http://$*, $(GARVERSION), $(DISTNAME))
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@rm -f $(WORKSRC)/config.cache
	@echo "`echo ac_cv_file_$(DESTDIR)$(includedir)/xorg/dri.h | sed -e 's%[^a-zA-Z0-9]%_%g'`=yes"        >> $(WORKSRC)/config.cache
	@echo "`echo ac_cv_file_$(DESTDIR)$(includedir)/xorg/dristruct.h | sed -e 's%[^a-zA-Z0-9]%_%g'`=yes"  >> $(WORKSRC)/config.cache
	@echo "`echo ac_cv_file_$(DESTDIR)$(includedir)/xorg/sarea.h | sed -e 's%[^a-zA-Z0-9]%_%g'`=yes"      >> $(WORKSRC)/config.cache
	@echo "`echo ac_cv_file_$(DESTDIR)$(includedir)/xorg/xf86Module.h | sed -e 's%[^a-zA-Z0-9]%_%g'`=yes" >> $(WORKSRC)/config.cache
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/drivers/via_drv.la
	@rm -f $(DESTDIR)$(libdir)/libviaXvMC.la
	@rm -f $(DESTDIR)$(libdir)/libviaXvMCPro.la
	@$(MAKECOOKIE)
