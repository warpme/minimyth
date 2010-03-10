GARNAME = sqlite
GARVERSION = 3.6.23
CATEGORIES = db
MASTER_SITES = http://www.sqlite.org/
DISTFILES = $(GARNAME)-amalgamation-$(GARVERSION).tar.gz
LICENSE =

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c
BUILDDEPS = utils/tcl

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-shared \
	--disable-static \
	--disable-readline \
	--enable-threadsafe \
	--enable-dynamic-extensions \
	--with-gnu-ld

include ../../gar.mk

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC),configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libsqlite3.la
	@$(MAKECOOKIE)
