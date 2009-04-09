GARNAME = bash
GARVERSION = 4.0
CATEGORIES = utils
MASTER_SITES  = ftp://ftp.gnu.org/gnu/$(GARNAME)/
MASTER_SITES += ftp://ftp.gnu.org/gnu/$(GARNAME)/$(DISTNAME)-patches/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES  =
PATCHFILES += \
	$(GARNAME)40-001 \
	$(GARNAME)40-002 \
	$(GARNAME)40-003 \
	$(GARNAME)40-004 \
	$(GARNAME)40-005 \
	$(GARNAME)40-006 \
	$(GARNAME)40-007 \
	$(GARNAME)40-008 \
	$(GARNAME)40-009 \
	$(GARNAME)40-010 \
	$(GARNAME)40-011 \
	$(GARNAME)40-012 \
	$(GARNAME)40-013 \
	$(GARNAME)40-014 \
	$(GARNAME)40-015 \
	$(GARNAME)40-016 \
	$(GARNAME)40-017
#PATCHFILES += $(DISTNAME)-perl.patch.gar
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

PATCHDIRLEVEL = 0

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--with-gnu-ld

include ../../gar.mk

libdir  := $(elibdir)
bindir  := $(ebindir)
sbindir := $(esbindir)

patch-%: normal-patch-%
	@$(MAKECOOKIE)

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@ln -fs bash $(DESTDIR)$(bindir)/sh
	@$(MAKECOOKIE)
