GARNAME = tiff
GARVERSION = 3.9.4
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

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libtiff.la
	@rm -f $(DESTDIR)$(libdir)/libtiffxx.la
	@$(MAKECOOKIE)
