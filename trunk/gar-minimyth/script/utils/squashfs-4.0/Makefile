GARNAME = squashfs
GARVERSION = 20090314Z
CATEGORIES = lib
MASTER_SITES = cvs://anonymous@$(GARNAME).cvs.sourceforge.net:/cvsroot/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES =
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/zlib

DISTNAME = $(GARNAME)$(GARVERSION)
WORKSRC  = $(WORKDIR)/$(DISTNAME)/squashfs-tools

BUILD_SCRIPTS   = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = custom

BUILD_ARGS = \
	CFLAGS="$(CFLAGS)"

include ../../gar.mk

CFLAGS := $(CFLAGS) -I. -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_GNU_SOURCE

cvs//%/$(DISTNAME).tar.bz2:
	@$(call FETCH_CVS, $*, $(GARNAME), $(GARVERSION), $(DISTNAME))
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

install-custom:
	@mkdir -p $(DESTDIR)$(bindir)
	@cp $(WORKSRC)/mksquashfs $(DESTDIR)$(bindir)/mksquashfs-4.0
	@cp $(WORKSRC)/unsquashfs $(DESTDIR)$(bindir)/unsquashfs-4.0
	@$(MAKECOOKIE)
