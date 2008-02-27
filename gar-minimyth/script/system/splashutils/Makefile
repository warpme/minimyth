GARNAME = splashutils
GARVERSION = 1.5.4
CATEGORIES = system
MASTER_SITES = http://dev.gentoo.org/~spock/projects/gensplash/archive/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-libadd.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/libjpeg lib/zlib lib/freetype

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-debug \
	--disable-deprecated \
	--enable-fbcondecor \
	--disable-helper \
	--disable-misc \
	--disable-test \
	--with-gnu-ld \
	--without-gpm \
	--without-mng \
	--without-png \
	--with-ttf \
	--with-ttf-kernel \
	--with-essential-prefix="$(if $(rootdir),$(rootdir),/)" \
	--with-essential-bindir="$(ebindir)" \
	--with-eseential-sbindir="$(esbindir)" \
	--with-essential-libdir="$(elibdir)" \
	--with-themedir="$(sysconfdir)/splash"

BUILD_ENV = \
	QUIET=false

include ../../gar.mk

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libfbsplash.la
	@rm -f $(DESTDIR)$(libdir)/libfbsplashrender.la
	@$(MAKECOOKIE)
