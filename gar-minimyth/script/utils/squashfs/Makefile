GARNAME = squashfs
GARVERSION = 3.1-r2
CATEGORIES = lib
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
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

CFLAGS := $(CFLAGS) -I. -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE

install-custom:
	@mkdir -p $(DESTDIR)$(bindir)
	@cp $(WORKSRC)/mksquashfs $(DESTDIR)$(bindir)
	@cp $(WORKSRC)/unsquashfs $(DESTDIR)$(bindir)
	@$(MAKECOOKIE)
