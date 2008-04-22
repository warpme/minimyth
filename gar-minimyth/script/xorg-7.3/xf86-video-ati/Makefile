GARNAME = xf86-video-ati
GARVERSION = 6.8.0
CATEGORIES = $(CATEGORY)
MASTER_SITES = $(XORG_MASTER_SITES)
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-pkg_config.patch
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/COPYING

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c \
	$(CATEGORY)/fontsproto \
	$(CATEGORY)/libdrm \
	$(CATEGORY)/randrproto \
	$(CATEGORY)/renderproto \
	$(CATEGORY)/videoproto \
	$(CATEGORY)/xextproto \
	$(CATEGORY)/xf86driproto \
	$(CATEGORY)/xf86miscproto \
	$(CATEGORY)/xineramaproto \
	$(CATEGORY)/xorg-server \
	$(CATEGORY)/xproto
BUILDDEPS = \
	$(CATEGORY)/util-macros \
	$(CATEGORY)/xorg-server \
	$(CATEGORY)/xorg-sgml-doctools

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--cache-file=config.cache \
	--enable-dri \
	--enable-exa \
	--with-gnu-ld

GAR_EXTRA_CONF += $(CATEGORY)/xorg/package-api.mk
include ../../gar.mk

pre-configure:
	@rm -f $(WORKSRC)/acinclude.m4
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@rm -f $(WORKSRC)/config.cache
	@echo "`echo ac_cv_file_$(DESTDIR)$(includedir)/xorg/damage.h | sed -e 's%[^a-zA-Z0-9]%_%g'`=yes"    >> $(WORKSRC)/config.cache
	@echo "`echo ac_cv_file_$(DESTDIR)$(includedir)/xorg/dri.h | sed -e 's%[^a-zA-Z0-9]%_%g'`=yes"       >> $(WORKSRC)/config.cache
	@echo "`echo ac_cv_file_$(DESTDIR)$(includedir)/xorg/dristruct.h | sed -e 's%[^a-zA-Z0-9]%_%g'`=yes" >> $(WORKSRC)/config.cache
	@echo "`echo ac_cv_file_$(DESTDIR)$(includedir)/xorg/sarea.h | sed -e 's%[^a-zA-Z0-9]%_%g'`=yes"     >> $(WORKSRC)/config.cache
	@echo "`echo ac_cv_file_$(prefix)/share/sgml/X11/defs.ent | sed -e 's%[^a-zA-Z0-9]%_%g'`=yes"        >> $(WORKSRC)/config.cache
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/drivers/ati_drv.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/drivers/mach64_drv.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/drivers/r128_drv.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/drivers/radeon_drv.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/multimedia/theatre_detect_drv.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/multimedia/theatre_drv.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/multimedia/theatre200_drv.la
	@$(MAKECOOKIE)
