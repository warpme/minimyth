GARNAME = xmacro
GARVERSION = pre0.3-20000911
CATEGORIES = X11
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-c++.patch $(DISTNAME)-makefile.patch
LICENSE = LGPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c xorg/xorg

BUILD_SCRIPTS   = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = $(WORKSRC)/Makefile

include ../../gar.mk
