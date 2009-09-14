GARNAME = squashfs
GARVERSION = 4.0
CATEGORIES = lib
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(GARNAME)$(GARVERSION).tar.gz
PATCHFILES =
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/zlib

WORKSRC  = $(WORKDIR)/$(GARNAME)$(GARVERSION)

BUILD_SCRIPTS   = $(WORKSRC)/squashfs-tools/Makefile
INSTALL_SCRIPTS = $(WORKSRC)/squashfs-tools/Makefile

BUILD_ARGS   = \
	CFLAGS="$(CFLAGS)"
INSTALL_ARGS = \
	INSTALL_DIR=$(DESTDIR)$(bindir)

include ../../gar.mk

CFLAGS := $(CFLAGS) -I. -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_GNU_SOURCE

pre-install:
	@rm -f $(DESTDIR)$(bindir)/mksquashfs
	@rm -f $(DESTDIR)$(bindir)/unsquashfs
	@$(MAKECOOKIE)
