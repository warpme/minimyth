GARNAME = xine-ui
GARVERSION = 0.99.5
CATEGORIES = mediaplayers
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/xine/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME).patch.gar $(DISTNAME)-pmaxsize.patch $(DISTNAME)-xscreensaver.patch $(DISTNAME)-xtest_disable.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c xorg/xorg lib/freetype lib/libpng system/lirc mediaplayers/xine-lib

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--cache-file=config.cache \
	--x-includes=$(DESTDIR)$(includedir) \
	--x-libraries=$(DESTDIR)$(libdir) \
	--with-gnu-ld \
	--with-xine-prefix=$(DESTDIR)$(prefix) \
	--with-xine-exec-prefix=$(DESTDIR)$(prefix) \
	--with-x \
	--without-readline \
	--with-aalib-prefix=$(DESTDIR)$(prefix) \
	--with-aalib-exec-prefix=$(DESTDIR)$(prefix)

include ../../gar.mk

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@echo "`echo ac_cv_file_$(DESTDIR)$(libdir)/liblirc_client.a | sed -e 's%[^a-zA-Z0-9]%_%g'`=yes" >  $(WORKSRC)/config.cache
	@echo "ac_cv_path_CURL_CONFIG=no"                                                                >> $(WORKSRC)/config.cache
	@echo "ac_cv_path_AALIB_CONFIG=no"                                                               >> $(WORKSRC)/config.cache
	@echo "ac_cv_path_CACA_CONFIG=no"                                                                >> $(WORKSRC)/config.cache
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
