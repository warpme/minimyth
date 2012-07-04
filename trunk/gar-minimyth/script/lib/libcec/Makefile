GARNAME = libcec
GARVERSION = 20120627-ebefc26c10
CATEGORIES = lib
MASTER_SITES = git://github.com/Pulse-Eight/libcec.git/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/cxx lib/lockdev system/udev

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-shared \
	--disable-static \
	--with-gnu-ld

include ../../gar.mk

git//%/$(DISTNAME).tar.bz2:
	@$(call FETCH_GIT, $*, $(word 2,$(subst -, ,$(GARVERSION))), $(DISTNAME))
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE) 

pre-configure:
	@$(call RUN_AUTOTOOLS)
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libcec.la
	@$(MAKECOOKIE)
