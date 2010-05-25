GARNAME = libcdio
GARVERSION = $(LIBCDIO_VERSION)
CATEGORIES = lib
MASTER_SITES = http://ftp.gnu.org/gnu/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-ac_arg_enable.patch
LICENSE = GPL3

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lang/cxx

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-cxx \
	--disable-cpp-progs \
	--enable-shared \
	--disable-static \
	--enable-joliet \
	--disable-rpath \
	--enable-rock \
	--disable-cddb \
	--disable-vcd-info \
	--without-cd-drive \
	--without-cd-info \
	--with-cd-paranoia \
	--without-cdda-player \
	--without-cd-read \
	--without-iso-info \
	--without-iso-read \
	--with-gnu-ld

include ../../gar.mk

# libcdio 0.82 fails to compile with GCC 4.5.0's link time optimization.
CFLAGS   := $(filter-out -flto -fuse-linker-plugin, $(CFLAGS))
CXXFLAGS := $(filter-out -flto -fuse-linker-plugin, $(CXXFLAGS))
LDFLAGS  := $(filter-out -flto -fuse-linker-plugin, $(LDFLAGS))

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(call FIX_LIBTOOL_LIBPATH,$(WORKSRC),configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libcdio.la
	@rm -f $(DESTDIR)$(libdir)/libcdio++.la
	@rm -f $(DESTDIR)$(libdir)/libcdio_cdda.la
	@rm -f $(DESTDIR)$(libdir)/libcdio_paranoia.la
	@rm -f $(DESTDIR)$(libdir)/libiso9660.la
	@rm -f $(DESTDIR)$(libdir)/libiso9660++.la
	@rm -f $(DESTDIR)$(libdir)/libudf.la
	@$(MAKECOOKIE)
