GARNAME = squashfs
GARVERSION = 20100630
CATEGORIES = lib
MASTER_SITES  = http://www.kernel.org/pub/linux/kernel/people/pkl/
MASTER_SITES += http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
MASTER_SITES += http://easynews.dl.sourceforge.net/sourceforge/sevenzip/
MASTER_SITES += cvs://anonymous@$(GARNAME).cvs.sourceforge.net:/cvsroot/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2 lzma465.tar.bz2
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/libattr lib/zlib

BUILD_SCRIPTS   = $(WORKSRC)/squashfs-tools/Makefile
INSTALL_SCRIPTS = $(WORKSRC)/squashfs-tools/Makefile

BUILD_ARGS   = \
	CFLAGS="$(CFLAGS)" \
	LZMA_SUPPORT=1 \
	LZMA_DIR="../../LZMA"
INSTALL_ARGS = \
	INSTALL_DIR=$(DESTDIR)$(bindir)

include ../../gar.mk

CFLAGS := $(CFLAGS) -I. -I../../LZMA/C -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE -D_GNU_SOURCE -DCOMP_DEFAULT=\\\"lzma\\\" -DLZMA_SUPPORT

cvs//%/$(DISTNAME).tar.bz2:
	@$(call FETCH_CVS, $*, $(GARNAME), $(GARVERSION), $(DISTNAME))
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

pre-install:
	@rm -f $(DESTDIR)$(bindir)/mksquashfs
	@rm -f $(DESTDIR)$(bindir)/unsquashfs
	@$(MAKECOOKIE)

extract-lzma465.tar.bz2:
	@mkdir -p $(WORKDIR)/LZMA
	@bzip2 -dc $(DOWNLOADDIR)/lzma465.tar.bz2 | tar -xf - -C $(WORKDIR)/LZMA
	@$(MAKECOOKIE)
