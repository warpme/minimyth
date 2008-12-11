GARNAME = hdparm
GARVERSION = 9.5
CATEGORIES = disk
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = hdparm
hdparm_LICENSE_TEXT = $(WORKSRC)/LICENSE.TXT

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

BUILD_SCRIPTS   = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = $(WORKSRC)/Makefile

DEFAULT_ARGS = \
	binprefix="$(prefix)" \
	manprefix="$(prefix)" \
	exec_prefix="$(exec_prefix)" \
	sbindir="$(sbindir)" \
	mandir="$(mandir)" \
	oldmandir="$(mandir)"
BUILD_ARGS   = \
	$(DEFAULT_ARGS)
INSTALL_ARGS = \
	$(DEFAULT_ARGS)

include ../../gar.mk
