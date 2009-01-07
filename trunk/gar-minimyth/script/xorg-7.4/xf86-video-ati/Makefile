GARNAME = xf86-video-ati
GARVERSION_TYPE =
GARVERSION = $(strip $(if $(filter git,$(GARVERSION_TYPE)) , \
	c0c33dab44e6966b1702d4e8cfba3537fc6e2d5c , \
	6.10.0 ))
CATEGORIES = $(CATEGORY)
MASTER_SITES = $(strip $(if $(filter git,$(GARVERSION_TYPE)) , \
	git://anongit.freedesktop.org/git/xorg/driver/xf86-video-ati/ , \
	$(XORG_MASTER_SITES) ))
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

CONFIGURE_ENV = \
	XORG_SGML_PATH="$(DESTDIR)$(includedir)/xorg"

GAR_EXTRA_CONF += $(CATEGORY)/xorg/package-api.mk
include ../../gar.mk

git//%$(DISTNAME).tar.bz2:
	@$(call FETCH_GIT, $*, $(GARVERSION), $(DISTNAME))
	@$(MAKECOOKIE)

x-checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE) 

pre-configure:
	@rm -f $(WORKSRC)/acinclude.m4
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@rm -f $(WORKSRC)/config.cache
	@echo "`echo ac_cv_file_$(DESTDIR)$(includedir)/xorg/damage.h | sed -e 's%[^a-zA-Z0-9]%_%g'`=yes"    >> $(WORKSRC)/config.cache
	@echo "`echo ac_cv_file_$(DESTDIR)$(includedir)/xorg/dri.h | sed -e 's%[^a-zA-Z0-9]%_%g'`=yes"       >> $(WORKSRC)/config.cache
	@echo "`echo ac_cv_file_$(DESTDIR)$(includedir)/xorg/dristruct.h | sed -e 's%[^a-zA-Z0-9]%_%g'`=yes" >> $(WORKSRC)/config.cache
	@echo "`echo ac_cv_file_$(DESTDIR)$(includedir)/xorg/sarea.h | sed -e 's%[^a-zA-Z0-9]%_%g'`=yes"     >> $(WORKSRC)/config.cache
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/drivers/ati_drv.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/drivers/radeon_drv.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/multimedia/theatre_detect_drv.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/multimedia/theatre_drv.la
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/multimedia/theatre200_drv.la
	@$(MAKECOOKIE)
