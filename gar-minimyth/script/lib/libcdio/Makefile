GARNAME = libcdio
GARVERSION = $(LIBCDIO_VERSION)
CATEGORIES = lib
MASTER_SITES = ftp://ftp.gnu.org/gnu/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz config.rpath
PATCHFILES = $(DISTNAME)-help2man.patch $(DISTNAME)-ac_arg_enable.patch $(DISTNAME).patch
LICENSE = LGPL2_1

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-cxx \
	--disable-cpp-progs \
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

extract-config.rpath:
	@cp $(DOWNLOADDIR)/config.rpath $(WORKSRC)/config.rpath
	@$(MAKECOOKIE)

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
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
