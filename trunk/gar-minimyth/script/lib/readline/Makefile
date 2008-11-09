GARNAME = readline
GARVERSION = 5.2
CATEGORIES = lib
MASTER_SITES  = ftp://ftp.gnu.org/gnu/$(GARNAME)/
MASTER_SITES += ftp://ftp.gnu.org/gnu/$(GARNAME)/$(DISTNAME)-patches/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = \
	$(subst -,,$(subst .,,$(DISTNAME)))-001 \
	$(subst -,,$(subst .,,$(DISTNAME)))-002 \
	$(subst -,,$(subst .,,$(DISTNAME)))-003 \
	$(subst -,,$(subst .,,$(DISTNAME)))-004 \
	$(subst -,,$(subst .,,$(DISTNAME)))-005 \
	$(subst -,,$(subst .,,$(DISTNAME)))-006 \
	$(subst -,,$(subst .,,$(DISTNAME)))-007 \
	$(subst -,,$(subst .,,$(DISTNAME)))-008 \
	$(subst -,,$(subst .,,$(DISTNAME)))-009 \
	$(subst -,,$(subst .,,$(DISTNAME)))-010 \
	$(subst -,,$(subst .,,$(DISTNAME)))-011 \
	$(subst -,,$(subst .,,$(DISTNAME)))-012
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
