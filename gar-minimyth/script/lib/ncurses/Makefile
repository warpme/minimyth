GARNAME = ncurses
GARVERSION = 5.6
CATEGORIES = lib
MASTER_SITES = ftp://ftp.gnu.org/gnu/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME).patch
LICENSE = MIT

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--with-build-cc="$(build_CC)" \
	--with-build-cppflags="$(build_CPPFLAGS)" \
	--with-build-cflags="$(build_CFLAGS)" \
	--with-build-ldflags="$(build_LDFLAGS)" \
	--with-build-libs="" \
	--disable-static \
	--enable-termcap \
	--with-shared \
	--without-cxx-binding \
	--without-ada \
	--without-ada-compiler

include ../../gar.mk

post-install:
	@cd $(DESTDIR)$(libdir) && ln -sf libncurses.so libtermcap.so
	@$(MAKECOOKIE)
