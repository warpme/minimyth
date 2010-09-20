GARNAME = squashfs
GARVERSION = 4.1
CATEGORIES = lib
MASTER_SITES  = http://www.kernel.org/pub/linux/kernel/people/pkl/
MASTER_SITES += http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
MASTER_SITES += http://easynews.dl.sourceforge.net/sourceforge/sevenzip/
MASTER_SITES += cvs://anonymous@$(GARNAME).cvs.sourceforge.net:/cvsroot/$(GARNAME)/
DISTFILES = $(GARNAME)$(GARVERSION).tar.gz lzma465.tar.bz2
PATCHFILES = $(DISTNAME).patch.gar
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/libattr lib/zlib

WORKSRC = $(WORKDIR)/$(GARNAME)$(GARVERSION)

BUILD_SCRIPTS   = $(WORKSRC)/squashfs-tools/Makefile
INSTALL_SCRIPTS = $(WORKSRC)/squashfs-tools/Makefile

include ../../gar.mk

LDFLAGS += -fwhole-program

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
