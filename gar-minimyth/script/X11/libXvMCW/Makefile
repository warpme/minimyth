GARNAME = libXvMCW
GARVERSION = 0.9.3
CATEGORIES = X11
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/unichrome/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-configure.patch
LICENSE =

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c X11/X11

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes=$(DESTDIR)$(x11includedir) \
	--x-libraries=$(DESTDIR)$(x11libdir) \
	--with-x \
	--with-gnu-ld \
	--with-config-path=$(shell echo '$(sysconfdir)/X11' | sed 's%/[/]*%/%g')
BUILD_ARGS     =
INSTALL_ARGS   = \
	DESTDIR="" \
	xconfigdir="$(DESTDIR)$(sysconfdir)/X11"

include ../../gar.mk

CppCmd       := $(shell echo $(CPP)    | sed 's%^$($(DESTIMG)_compiler_prefix)%%')
CcCmd        := $(shell echo $(CC)     | sed 's%^$($(DESTIMG)_compiler_prefix)%%')
CplusplusCmd := $(shell echo $(CXX)    | sed 's%^$($(DESTIMG)_compiler_prefix)%%')
LdCmd        := $(shell echo $(LD)     | sed 's%^$($(DESTIMG)_compiler_prefix)%%')
RanlibCmd    := $(shell echo $(RANLIB) | sed 's%^$($(DESTIMG)_compiler_prefix)%%')
AsCmd        := $(shell echo $(AS)     | sed 's%^$($(DESTIMG)_compiler_prefix)%%')
ArCmd        := $(shell echo $(AR)     | sed 's%^$($(DESTIMG)_compiler_prefix)%%')

configure-custom:
	@cd $(WORKSRC) ; xmkmf $(mm_HOME)/script/X11/X11/$(WORKDIR)/xc
	@sed -i "s%= $(ArCmd)%= $(AR)%"         $(WORKSRC)/Makefile
	@sed -i "s%= $(AsCmd)%= $(AS)%"         $(WORKSRC)/Makefile
	@sed -i "s%= $(CcCmd)%= $(CC)%"         $(WORKSRC)/Makefile
	@sed -i "s%= $(CplusplusCmd)%= $(CXX)%" $(WORKSRC)/Makefile
	@sed -i "s%= $(CppCmd)%= $(CPP)%"       $(WORKSRC)/Makefile
	@sed -i "s%= $(LdCmd)%= $(LD)%"         $(WORKSRC)/Makefile
	@sed -i "s%= $(RanlibCmd)%= $(RANLIB)%" $(WORKSRC)/Makefile
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(x11libdir)/libXvMCW.la
	@$(MAKECOOKIE)
