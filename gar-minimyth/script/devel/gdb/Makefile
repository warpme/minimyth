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

CONFIGURE_ENV = CFLAGS_FOR_BUILD="$(build_CFLAGS)" LDFLAGS_FOR_BUILD="$(build_LDFLAGS)"
BUILD_ENV     = CFLAGS_FOR_BUILD="$(build_CFLAGS)" LDFLAGS_FOR_BUILD="$(build_LDFLAGS)" bash_cv_have_mbstate_t=yes
INSTALL_ENV   = CFLAGS_FOR_BUILD="$(build_CFLAGS)" LDFLAGS_FOR_BUILD="$(build_LDFLAGS)"

include ../../gar.mk

post-install:
	@rm -f $(DESTDIR)$(libdir)/libbfd.la
	@rm -f $(DESTDIR)$(libdir)/libopcodes.la
	@$(if $(filter $(GARHOST), $(GARTARGET)),, rm -f $(DESTDIR)$(prefix)/$(GARHOST)/$(GARTARGET)/lib/libbfd.la)
	@$(if $(filter $(GARHOST), $(GARTARGET)),, rm -f $(DESTDIR)$(prefix)/$(GARHOST)/$(GARTARGET)/lib/libopcodes.la)
	@$(MAKECOOKIE)
