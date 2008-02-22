GARNAME = file
GARVERSION = 4.23
CATEGORIES = utils
MASTER_SITES  = ftp://ftp.astron.com/pub/$(GARNAME)/
MASTER_SITES += ftp://ftp.gw.com/mirrors/pub/unix/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
#PATCHFILES = $(DISTNAME)-perl.patch.gar
LICENSE = BSD_2_Clause

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--with-gnu-ld

include ../../gar.mk

post-install:
	@rm -rf $(DESTDIR)$(libdir)/libmagic.la
	@$(MAKECOOKIE)
