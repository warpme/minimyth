GARNAME = boost
GARVERSION = 1.37.0
CATEGORIES = lib
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(GARNAME)_$(subst .,_,$(GARVERSION)).tar.bz2
PATCHFILES = $(DISTNAME).patch.gar
LICENSE = boost
boost_LICENSE_TEXT = $(WORKSRC)/LICENSE_1_0.txt

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c++

WORKSRC = $(WORKDIR)/$(GARNAME)_$(subst .,_,$(GARVERSION))

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = \
	--with-toolset=gcc \
	--without-icu \
	--with-python=false \
	--prefix=$(prefix) \
	--exec-prefix=$(exec_prefix) \
	--libdir=$(libdir) \
	--includedir=$(includedir)

INSTALL_OVERRIDE_DIRS = prefix exec_prefix libdir includedir

GAR_EXTRA_CONF += devel/gcc/package-api.mk
include ../../gar.mk

post-configure:
	@echo "using gcc : $(GCC_VERSION) : $(CXX) ;" >  $(WORKSRC)/user-config.jam
	@echo "using gcc : $(GCC_VERSION) : $(CXX) ;" >> $(WORKSRC)/tools/build/v2/user-config.jam
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libboost_test_exec_monitor-gcc43-mt.a
	@rm -f $(DESTDIR)$(libdir)/libboost_test_exec_monitor-gcc43-mt-1_37.a
	@$(MAKECOOKIE)
