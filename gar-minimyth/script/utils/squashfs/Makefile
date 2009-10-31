GARNAME = squashfs
GARVERSION = 4.0-lzma-snapshot
CATEGORIES = lib
MASTER_SITES  = http://www.kernel.org/pub/linux/kernel/people/pkl/
MASTER_SITES += http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
MASTER_SITES += http://easynews.dl.sourceforge.net/sourceforge/sevenzip/
DISTFILES = $(GARNAME)$(GARVERSION).tgz lzma465.tar.bz2
#DISTFILES = $(GARNAME)$(GARVERSION).tar.gz
#PATCHFILES = $(DISTNAME)-multi_core_fix.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/zlib

WORKSRC  = $(WORKDIR)/$(GARNAME)$(GARVERSION)

BUILD_SCRIPTS   = $(WORKSRC)/squashfs-tools/Makefile
INSTALL_SCRIPTS = $(WORKSRC)/squashfs-tools/Makefile

BUILD_ARGS   = \
	CFLAGS="$(CFLAGS)" \
	LZMA_SUPPORT=1 \
	LZMA_DIR=$(PWD)/$(WORKDIR)/LZMA
INSTALL_ARGS = \
	INSTALL_DIR=$(DESTDIR)$(bindir)

include ../../gar.mk

CFLAGS := $(CFLAGS) -I. -I$(PWD)/$(WORKDIR)/LZMA/C -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_GNU_SOURCE -DCOMP_DEFAULT=\\\"lzma\\\" -DLZMA_SUPPORT

pre-install:
	@rm -f $(DESTDIR)$(bindir)/mksquashfs
	@rm -f $(DESTDIR)$(bindir)/unsquashfs
	@$(MAKECOOKIE)

extract-lzma465.tar.bz2:
	@mkdir -p $(WORKDIR)/LZMA
	@bzip2 -dc $(DOWNLOADDIR)/lzma465.tar.bz2 | tar -xf - -C $(WORKDIR)/LZMA
	@$(MAKECOOKIE)
