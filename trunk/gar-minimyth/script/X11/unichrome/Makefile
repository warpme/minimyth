GARNAME = unichrome
GARVERSION = 20050718
CATEGORIES = X11
MASTER_SITES  = http://myth.ivor.org/unichrome/
MASTER_SITES += http://myth.ivor.org/unichrome/old/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE =

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c X11/X11

CONFIGURE_SCRIPTS = unichrome libxvmc
BUILD_SCRIPTS     = $(WORKSRC)/unichrome/Makefile $(WORKSRC)/libxvmc/Makefile
INSTALL_SCRIPTS   = unichrome libxvmc

include ../../gar.mk

CppCmd       := $(shell echo $(CPP)    | sed 's%^$($(DESTIMG)_compiler_prefix)%%')
CcCmd        := $(shell echo $(CC)     | sed 's%^$($(DESTIMG)_compiler_prefix)%%')
CplusplusCmd := $(shell echo $(CXX)    | sed 's%^$($(DESTIMG)_compiler_prefix)%%')
LdCmd        := $(shell echo $(LD)     | sed 's%^$($(DESTIMG)_compiler_prefix)%%')
RanlibCmd    := $(shell echo $(RANLIB) | sed 's%^$($(DESTIMG)_compiler_prefix)%%')
AsCmd        := $(shell echo $(AS)     | sed 's%^$($(DESTIMG)_compiler_prefix)%%')
ArCmd        := $(shell echo $(AR)     | sed 's%^$($(DESTIMG)_compiler_prefix)%%')

configure-unichrome:
	@cd $(WORKSRC)/unichrome ; xmkmf $(mm_HOME)/script/X11/X11/$(WORKDIR)/xc
	@sed -i "s%= $(ArCmd)%= $(AR)%"         $(WORKSRC)/unichrome/Makefile
	@sed -i "s%= $(AsCmd)%= $(AS)%"         $(WORKSRC)/unichrome/Makefile
	@sed -i "s%= $(CcCmd)%= $(CC)%"         $(WORKSRC)/unichrome/Makefile
	@sed -i "s%= $(CplusplusCmd)%= $(CXX)%" $(WORKSRC)/unichrome/Makefile
	@sed -i "s%= $(CppCmd)%= $(CPP)%"       $(WORKSRC)/unichrome/Makefile
	@sed -i "s%= $(LdCmd)%= $(LD)%"         $(WORKSRC)/unichrome/Makefile
	@sed -i "s%= $(RanlibCmd)%= $(RANLIB)%" $(WORKSRC)/unichrome/Makefile
	@$(MAKECOOKIE)

configure-libxvmc:
	@cd $(WORKSRC)/libxvmc; xmkmf $(mm_HOME)/script/X11/X11/$(WORKDIR)/xc
	@sed -i "s%= $(ArCmd)%= $(AR)%"         $(WORKSRC)/libxvmc/Makefile
	@sed -i "s%= $(AsCmd)%= $(AS)%"         $(WORKSRC)/libxvmc/Makefile
	@sed -i "s%= $(CcCmd)%= $(CC)%"         $(WORKSRC)/libxvmc/Makefile
	@sed -i "s%= $(CplusplusCmd)%= $(CXX)%" $(WORKSRC)/libxvmc/Makefile
	@sed -i "s%= $(CppCmd)%= $(CPP)%"       $(WORKSRC)/libxvmc/Makefile
	@sed -i "s%= $(LdCmd)%= $(LD)%"         $(WORKSRC)/libxvmc/Makefile
	@sed -i "s%= $(RanlibCmd)%= $(RANLIB)%" $(WORKSRC)/libxvmc/Makefile
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
