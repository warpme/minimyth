GARNAME = ncurses
GARVERSION = 5.4
CATEGORIES = lib
MASTER_SITES = ftp://ftp.gnu.org/gnu/ncurses/
DISTFILES = $(GARNAME)-$(GARVERSION).tar.gz
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

post-patch:
	@sed -i '/[ \t]*CPPFLAGS=/s% *-I\\$$(includedir)%%g' $(WORKSRC)/configure
	@sed -i '/[ \t]*ACPPFLAGS=/s% *-I\\$$(includedir)%%g' $(WORKSRC)/configure
	@sed -i 's% @BUILD_CPPFLAGS@% -I$$(INCDIR) @BUILD_CPPFLAGS@%' $(WORKSRC)/ncurses/Makefile.in
	@$(MAKECOOKIE)

post-install:
	@cd $(DESTDIR)$(libdir) && ln -sf libncurses.so libtermcap.so
	@$(MAKECOOKIE)
