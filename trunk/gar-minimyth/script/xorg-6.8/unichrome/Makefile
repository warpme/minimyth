GARNAME = unichrome
GARVERSION = 20050815
CATEGORIES = xorg-6.8
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-imakefile.patch
LICENSE = MIT

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c xorg-6.8/X11

CONFIGURE_SCRIPTS = unichrome libxvmc
BUILD_SCRIPTS     = $(WORKSRC)/unichrome/Makefile $(WORKSRC)/libxvmc/Makefile
INSTALL_SCRIPTS   = unichrome libxvmc

GAR_EXTRA_CONF += xorg-6.8/X11/package-api.mk
include ../../gar.mk

CFLAGS   := $(patsubst -O%,,$(CFLAGS)  ) -O2
CXXFLAGS := $(patsubst -O%,,$(CXXFLAGS)) -O2

svn//%/$(DISTNAME).tar.bz2:
	@cd $(PARTIALDIR); rm -rf $(GARNAME)
	@cd $(PARTIALDIR); svn co -r $(GARVERSION) http://$* $(GARNAME)
	@cd $(PARTIALDIR); rm -rf $(DISTNAME)
	@cd $(PARTIALDIR); mv $(GARNAME) $(DISTNAME)
	@cd $(PARTIALDIR); tar -jcf $(DISTNAME).tar.bz2 $(DISTNAME)
	@cd $(PARTIALDIR); rm -rf $(DISTNAME)
	@$(MAKECOOKIE)

disabled-checksum-$(DISTNAME).tar.bz2:
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
