GARNAME = gdb
GARVERSION = 6.4
CATEGORIES = devel
MASTER_SITES = ftp://ftp.gnu.org/gnu/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = GPL2/LGPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/ncurses

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST)

DEFAULT_ENV   = \
        AR_FOR_BUILD="$(build_AR)" \
        AS_FOR_BUILD="$(build_AS)" \
        CC_FOR_BUILD="$(build_CC)" \
        CFLAGS_FOR_BUILD="$(build_CFLAGS)" \
        CXX_FOR_BUILD="$(build_CXX)" \
        CXXFLAGS_FOR_BUILD="$(build_CXXFLAGS)" \
        LD_FOR_BUILD="$(build_LD)" \
        LDFLAGS_FOR_BUILD="$(build_LDFLAGS)" \
        NM_FOR_BUILD="$(NM)" \
        RANLIB_FOR_BUILD="$(RANLIB)"
CONFIGURE_ENV = $(DEFAULT_ENV)
BUILD_ENV     = $(DEFAULT_ENV)
INSTALL_ENV   = $(DEFAULT_ENV)

include ../../gar.mk

post-install:
	@rm -f $(DESTDIR)$(libdir)/libbfd.la
	@rm -f $(DESTDIR)$(libdir)/libopcodes.la
	@$(if $(filter $(GARHOST), $(GARTARGET)),, rm -f $(DESTDIR)$(prefix)/$(GARHOST)/$(GARTARGET)/lib/libbfd.la)
	@$(if $(filter $(GARHOST), $(GARTARGET)),, rm -f $(DESTDIR)$(prefix)/$(GARHOST)/$(GARTARGET)/lib/libopcodes.la)
	@$(MAKECOOKIE)
