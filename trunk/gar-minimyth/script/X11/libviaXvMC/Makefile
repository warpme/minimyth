GARNAME = libxvmc
GARVERSION = 20050514
CATEGORIES = X11
MASTER_SITES = cvs://anonymous@cvs.sourceforge.net:/cvsroot/unichrome/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-cn400.patch
LICENSE =

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c X11/X11 X11/via_drv

CONFIGURE_SCRIPTS = $(DISTNAME)
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(DISTNAME)

include ../../gar.mk

CppCmd       := $(shell echo $(CPP)    | sed 's%^$($(DESTIMG)_compiler_prefix)%%')
CcCmd        := $(shell echo $(CC)     | sed 's%^$($(DESTIMG)_compiler_prefix)%%')
CplusplusCmd := $(shell echo $(CXX)    | sed 's%^$($(DESTIMG)_compiler_prefix)%%')
LdCmd        := $(shell echo $(LD)     | sed 's%^$($(DESTIMG)_compiler_prefix)%%')
RanlibCmd    := $(shell echo $(RANLIB) | sed 's%^$($(DESTIMG)_compiler_prefix)%%')
AsCmd        := $(shell echo $(AS)     | sed 's%^$($(DESTIMG)_compiler_prefix)%%')
ArCmd        := $(shell echo $(AR)     | sed 's%^$($(DESTIMG)_compiler_prefix)%%')

cvs//%$(DISTNAME).tar.gz:
	@cd $(PARTIALDIR); rm -rf $(GARNAME)
	@cd $(PARTIALDIR); cvs -z3 -d:pserver:$* co -D $(GARVERSION) $(GARNAME)
	@cd $(PARTIALDIR); rm -rf $(DISTNAME)
	@cd $(PARTIALDIR); mv $(GARNAME) $(DISTNAME)
	@cd $(PARTIALDIR); tar -zc $(DISTNAME) -f $(DISTNAME).tar.gz
	@cd $(PARTIALDIR); rm -rf $(DISTNAME)
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.gz:
	@$(MAKECOOKIE)

configure-$(DISTNAME):
	@cd $(WORKSRC); xmkmf $(mm_HOME)/script/X11/X11/$(WORKDIR)/xc
	@sed -i "s%= $(ArCmd)%= $(AR)%"         $(WORKSRC)/Makefile
	@sed -i "s%= $(AsCmd)%= $(AS)%"         $(WORKSRC)/Makefile
	@sed -i "s%= $(CcCmd)%= $(CC)%"         $(WORKSRC)/Makefile
	@sed -i "s%= $(CplusplusCmd)%= $(CXX)%" $(WORKSRC)/Makefile
	@sed -i "s%= $(CppCmd)%= $(CPP)%"       $(WORKSRC)/Makefile
	@sed -i "s%= $(LdCmd)%= $(LD)%"         $(WORKSRC)/Makefile
	@sed -i "s%= $(RanlibCmd)%= $(RANLIB)%" $(WORKSRC)/Makefile
	@rm -rf $(mm_HOME)/script/X11/X11/$(WORKDIR)/xc/lib/XvMC/hw/via
	@ln -s  $(mm_HOME)/script/X11/$(GARNAME)/$(WORKSRC) \
	        $(mm_HOME)/script/X11/X11/$(WORKDIR)/xc/lib/XvMC/hw/via
	@$(MAKECOOKIE)

install-$(DISTNAME):
	@mkdir -p $(DESTDIR)$(x11libdir)
	@cp -df $(WORKSRC)/libviaXvMC.so      $(DESTDIR)$(x11libdir)
	@cp -df $(WORKSRC)/libviaXvMC.so.*    $(DESTDIR)$(x11libdir)
	@cp -df $(WORKSRC)/libviaXvMCPro.so   $(DESTDIR)$(x11libdir)
	@cp -df $(WORKSRC)/libviaXvMCPro.so.* $(DESTDIR)$(x11libdir)
	@cp -f  $(WORKSRC)/vldXvMC.h          $(DESTDIR)$(x11includedir)/X11/extensions
	@$(MAKECOOKIE)
