GARNAME = intltool
GARVERSION = 0.40.6
CATEGORIES = devel
MASTER_SITES = http://ftp.gnome.org/pub/gnome/sources/$(GARNAME)/0.40/
DISTFILES = $(DISTNAME).tar.bz2
#PATCHFILES = $(DISTNAME)-perl.patch.gar
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS   = lang/c perl/perl perl/perl-XML-Parser
BUILDDEPS = perl/perl perl/perl-XML-Parser

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST)

include ../../gar.mk

