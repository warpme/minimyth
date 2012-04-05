GARNAME = kmod
GARVERSION = 7
CATEGORIES = lib
MASTER_SITES = http://ftp.kernel.org/pub/linux/utils/kernel/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = GPL2/LGPL2_1

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile links

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-silent-rules \
	--disable-static \
	--enable-shared \
	--enable-tools \
	--enable-logging \
	--disable-debug \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--with-gnu-ld \
	--without-xz \
	--without-zlib

include ../../gar.mk

bindir  := $(esbindir)
sbindir := $(esbindir)
libdir  := $(elibdir)

pre-configure:
	@$(call RUN_AUTOTOOLS)
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

install-links:
	@rm -f $(DESTDIR)$(bindir)/depmod
	@ln -s kmod $(DESTDIR)$(bindir)/depmod
	@rm -f $(DESTDIR)$(bindir)/insmod
	@ln -s kmod $(DESTDIR)$(bindir)/insmod
	@rm -f $(DESTDIR)$(bindir)/lsmod
	@ln -s kmod $(DESTDIR)$(bindir)/lsmod
	@rm -f $(DESTDIR)$(bindir)/modinfo
	@ln -s kmod $(DESTDIR)$(bindir)/modinfo
	@rm -f $(DESTDIR)$(bindir)/modprobe
	@ln -s kmod $(DESTDIR)$(bindir)/modprobe
	@rm -f $(DESTDIR)$(bindir)/rmmod
	@ln -s kmod $(DESTDIR)$(bindir)/rmmod
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libkmod.la
	@$(MAKECOOKIE)
