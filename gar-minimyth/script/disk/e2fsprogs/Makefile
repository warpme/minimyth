GARNAME = e2fsprogs
GARVERSION = 1.41.12
CATEGORIES = disk
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-chmod.patch
LICENSE = GPL2/LGPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c utils/util-linux-ng

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

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
	--disable-libuuid \
	--disable-libblkid \
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

# e2fsprogs 1.41.12 fails to compile with GCC 4.5.0's link time optimization (x86_64 has fPIC related error).
CFLAGS := $(filter-out -flto -fuse-linker-plugin, $(CFLAGS))

pre-configure:
	@$(call FIX_LIBTOOL_LIBPATH,$(WORKSRC),configure)
	@$(MAKECOOKIE)
