GARNAME = xf86-video-i810
GARVERSION = 1.4.1.3
CATEGORIES = xorg-new
MASTER_SITES = http://xorg.freedesktop.org/releases/X11R$(XORG_VERSION)/src/driver/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/COPYING

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c xorg-new/fontsproto xorg-new/libdrm xorg-new/libXvMC xorg-new/xf86driproto xorg-new/xorg-server xorg-new/xproto

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--cache-file=config.cache \
	--with-gnu-ld

GAR_EXTRA_CONF += xorg-new/xorg/package-api.mk
include ../../gar.mk

as_valid=

pre-configure:
	@rm -f $(WORKSRC)/config.cache
	@echo "`echo ac_cv_file_$(DESTDIR)$(includedir)/xorg/dri.h | sed -e 's%[^a-zA-Z0-9]%_%g'`=yes"       >> $(WORKSRC)/config.cache
	@echo "`echo ac_cv_file_$(DESTDIR)$(includedir)/xorg/dristruct.h | sed -e 's%[^a-zA-Z0-9]%_%g'`=yes" >> $(WORKSRC)/config.cache
	@echo "`echo ac_cv_file_$(DESTDIR)$(includedir)/xorg/sarea.h | sed -e 's%[^a-zA-Z0-9]%_%g'`=yes"     >> $(WORKSRC)/config.cache
	@echo "`echo ac_cv_file_$(prefix)/share/X11/sgml/defs.ent | sed -e 's%[^a-zA-Z0-9]%_%g'`=no"         >> $(WORKSRC)/config.cache
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/drivers/i810_drv.la
	@rm -f $(DESTDIR)$(libdir)/libI810XvMC.la
	@$(MAKECOOKIE)
