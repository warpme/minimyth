GARNAME = readline
GARVERSION = 6.0
CATEGORIES = lib
MASTER_SITES  = http://ftp.gnu.org/gnu/$(GARNAME)/
MASTER_SITES += http://ftp.gnu.org/gnu/$(GARNAME)/$(DISTNAME)-patches/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = \
	$(GARNAME)$(subst .,,$(GARVERSION))-001 \
	$(GARNAME)$(subst .,,$(GARVERSION))-002 \
	$(GARNAME)$(subst .,,$(GARVERSION))-003 \
	$(GARNAME)$(subst .,,$(GARVERSION))-004
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/ncurses

PATCHDIRLEVEL = 0

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-shared \
	--disable-static \
	--with-curses \
	--without-purify

include ../../gar.mk

patch-%: normal-patch-%
	@$(MAKECOOKIE)
