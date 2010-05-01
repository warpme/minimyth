GARNAME = ppl
GARVERSION = 0.10.2
CATEGORIES = lib
MASTER_SITES = http://www.cs.unipr.it/ppl/Download/ftp/releases/$(GARVERSION)/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = GPL3

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/gmp

CONFIGURE_SCRIPTS  = $(WORKSRC)/configure
BUILD_SCRIPTS      = $(WORKSRC)/Makefile
INSTALL_SCRIPTS    = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-silent-rules \
	--disable-rpath \
	--enable-shared \
	--disable-static \
	--with-cc="$(CC)" \
	--with-cxx="$(CXX)" \
	--with-cflags="$(CFLAGS)" \
	--with-cxxflags="$(CXXFLAGS)" \
	--with-gnu-ld \
  	--with-libgmp-prefix=$(DESTDIR)$(prefix) \
  	--with-libgmpxx-prefix=$(DESTDIR)$(prefix)

include ../../gar.mk

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libppl.la
	@rm -f $(DESTDIR)$(libdir)/libppl_c.la
	@rm -f $(DESTDIR)$(libdir)/libpwl.la
	@$(MAKECOOKIE)
