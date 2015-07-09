GARNAME = sqlite
GARVERSION = autoconf-3081002
CATEGORIES = db
MASTER_SITES = http://www.sqlite.org/2015
DISTFILES = $(DISTNAME).tar.gz
LICENSE =

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c lib/readline lib/ncurses
BUILDDEPS = utils/tcl

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-shared \
	--disable-static \
	--enable-readline \
	--enable-threadsafe \
	--enable-dynamic-extensions \
	--with-gnu-ld

include ../../gar.mk

# sqlite autoconf-3081002 fails to parallel build sometimes.
PARALLELMFLAGS := -j1

pre-configure:
	@$(call RUN_AUTOTOOLS)
	@$(call FIX_LIBTOOL,$(WORKSRC),configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libsqlite3.la
	@$(MAKECOOKIE)
