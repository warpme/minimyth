GARNAME = xf86-video-openchrome
GARVERSION = 342
CATEGORIES = $(CATEGORY)
MASTER_SITES = svn://svn.openchrome.org/svn/trunk/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-vt1625_ntsc_modes.patch $(DISTNAME)-ticket-78-20070308.patch
LICENSE = MIT

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c \
	$(CATEGORY)/fontsproto \
	$(CATEGORY)/glproto \
	$(CATEGORY)/libdrm \
	$(CATEGORY)/libX11 \
	$(CATEGORY)/libXvMC \
	$(CATEGORY)/randrproto \
	$(CATEGORY)/renderproto \
	$(CATEGORY)/videoproto \
	$(CATEGORY)/xextproto \
	$(CATEGORY)/xf86driproto \
	$(CATEGORY)/xorg-server \
	$(CATEGORY)/xproto

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--cache-file=config.cache \
	--enable-dri \
	--with-gnu-ld

include ../../gar.mk

CFLAGS   := $(patsubst -O%,,$(CFLAGS)  ) -O2
CXXFLAGS := $(patsubst -O%,,$(CXXFLAGS)) -O2

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
