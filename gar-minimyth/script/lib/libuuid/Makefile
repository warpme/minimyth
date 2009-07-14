GARNAME = e2fsprogs-libs
GARVERSION = 1.41.8
CATEGORIES = lib
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/e2fsprogs/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-chmod.patch
LICENSE = BSD_3_Clause

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/lib/uuid/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/lib/uuid/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-verbose-makecmds \
	--disable-compression \
	--disable-htree \
	--enable-elf-shlibs \
	--disable-bsd-shlibs \
	--disable-profile \
	--disable-jbd-debug \
	--disable-blkid-debug \
	--disable-testio-debug \
	--enable-libuuid \
	--enable-libblkid \
	--disable-debugfs \
	--disable-imager \
	--disable-resizer \
	--disable-fsck \
	--disable-e2initrd-helper \
	--enable-tls \
	--disable-uuidd \
	--enable-nls \
	--disable-rpath \
	--with-gnu-ld

include ../../gar.mk

libdir := $(elibdir)

pre-configure:
	@$(call FIX_LIBTOOL_LIBPATH,$(WORKSRC),configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libuuid.a
	@$(MAKECOOKIE)
