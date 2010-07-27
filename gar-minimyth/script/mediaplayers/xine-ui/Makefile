GARNAME = xine-ui
GARVERSION = 3049
CATEGORIES = mediaplayers
MASTER_SITES = hg://hg.debian.org/hg/xine-lib/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-librt.patch $(DISTNAME)-fork_wait.patch $(DISTNAME)-lirc.patch $(DISTNAME).patch.gar $(DISTNAME)-xscreensaver.patch $(DISTNAME)-xtest_disable.patch $(DISTNAME)-desktop_disable.patch
#PATCHFILES = $(DISTNAME)-fork_wait.patch $(DISTNAME)-lirc.patch $(DISTNAME).patch.gar $(DISTNAME)-pmaxsize.patch $(DISTNAME)-xscreensaver.patch $(DISTNAME)-xtest_disable.patch
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
	--enable-nls \
	--disable-rpath \
	--enable-shm \
	--enable-shm-default \
	--enable-xinerama \
	--disable-aalibtest \
	--disable-mbs \
	--enable-xft \
	--enable-lirc \
	--disable-vdr-keys \
	--disable-nvtvsimple \
	--disable-debug \
	--with-gnu-ld \
	--with-x \
	--without-readline \
	--without-curl \
	--without-aalib \
	--without-caca \
	--without-fb \
	--without-tar

include ../../gar.mk

hg//%$(DISTNAME).tar.bz2:
	@$(call FETCH_HG, $*, $(GARVERSION), $(DISTNAME))
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(call FIX_LIBTOOL_LIBPATH,$(WORKSRC),configure)
	@$(MAKECOOKIE)

clean-all:
	@$(MAKE) -C ../xine-lib clean
	@$(MAKE) -C ../xine-ui  clean
	@rm -rf $(DESTDIR)$(bindir)-config/xine-config
	@rm -rf $(DESTDIR)$(bindir)-config/$(compiler_prefix)xine-config
	@rm -rf $(DESTDIR)$(includedir)/xine
	@rm -rf $(DESTDIR)$(includedir)/xine.h
	@rm -rf $(DESTDIR)$(libdir)/xine
	@rm -rf $(DESTDIR)$(libdir)/libxine.*
	@rm -rf $(DESTDIR)$(datadir)/xine
	@rm -rf $(DESTDIR)$(datadir)/xine-lib
	@rm -rf $(DESTDIR)$(docdir)/xine
	@rm -rf $(DESTDIR)$(docdir)/xine-lib
