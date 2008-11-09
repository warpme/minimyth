GARNAME = xine-ui
GARVERSION = 0.99.5
CATEGORIES = mediaplayers
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/xine/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-lirc_shared.patch $(DISTNAME).patch.gar $(DISTNAME)-pmaxsize.patch $(DISTNAME)-xscreensaver.patch $(DISTNAME)-xtest_disable.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c xorg/xorg lib/freetype lib/libpng system/lirc mediaplayers/xine-lib

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes=$(DESTDIR)$(includedir) \
	--x-libraries=$(DESTDIR)$(libdir) \
	--disable-rpath \
	--with-gnu-ld \
	--with-x \
	--without-readline \
	--without-curl \
	--without-aalib \
	--without-caca

include ../../gar.mk

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

clean-all:
	@$(MAKE) -C ../xine-lib clean
	@$(MAKE) -C ../xine-ui  clean
	@rm -rf $(DESTDIR)$(bindir)/xine-config
	@rm -rf $(DESTDIR)$(includedir)/xine
	@rm -rf $(DESTDIR)$(includedir)/xine.h
	@rm -rf $(DESTDIR)$(libdir)/xine
	@rm -rf $(DESTDIR)$(libdir)/libxine.*
	@rm -rf $(DESTDIR)$(datadir)/xine
	@rm -rf $(DESTDIR)$(docdir)/xine
