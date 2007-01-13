GARNAME = lcdproc
GARVERSION = 0.4.5
CATEGORIES = system
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/ncurses

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes=$(DESTDIR)$(x11includedir) \
	--x-libraries=$(DESTDIR)$(x11libdir) \
	--enable-drivers=mtxorb,cfontz,cwlnx,curses,lb216,hd44780,bayrad,glk,stv5730,sed1330,sed1520,lcdm001,t6963,wirz-sli,sgx120

include ../../gar.mk
