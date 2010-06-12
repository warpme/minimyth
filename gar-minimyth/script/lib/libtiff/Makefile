GARNAME = tiff
GARVERSION = 3.9.3
CATEGORIES = lib
MASTER_SITES  = http://ftp.remotesensing.org/pub/libtiff/
MASTER_SITES += http://ftp.remotesensing.org/pub/libtiff/old
MASTER_SITES += ftp://ftp.remotesensing.org/pub/libtiff/
MASTER_SITES += ftp://ftp.remotesensing.org/pub/libtiff/old/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = libtiff
libtiff_LICENSE_TEXT = $(WORKSRC)/COPYRIGHT

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lang/cxx lib/zlib lib/libjpeg

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-shared \
	--disable-static \
	--with-gnu-ld \
	--without-x

include ../../gar.mk

# Fails to compile with GCC's link time optimization.
CFLAGS   := $(filter-out -flto -fuse-linker-plugin, $(CFLAGS))
CXXFLAGS := $(filter-out -flto -fuse-linker-plugin, $(CXXFLAGS))
LDFLAGS  := $(filter-out -flto -fuse-linker-plugin, $(LDFLAGS))

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libtiff.la
	@rm -f $(DESTDIR)$(libdir)/libtiffxx.la
	@$(MAKECOOKIE)
