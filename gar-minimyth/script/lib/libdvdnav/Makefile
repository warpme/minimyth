GARNAME = libdvdnav
GARVERSION = 1191
CATEGORIES = lib
MASTER_SITES = svn://svn.mplayerhq.hu/dvdnav/trunk/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-destdir.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/libdvdread

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--with-gnu-ld

include ../../gar.mk

# libdvdnav 1191 fails to compile with GCC 4.5.0's link time optimization.
CFLAGS := $(filter-out -flto -fuse-linker-plugin, $(CFLAGS))

svn//%/$(DISTNAME).tar.bz2:
	@$(call FETCH_SVN, svn://$*, $(GARVERSION), $(DISTNAME))
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libdvdnav.la
	@rm -f $(DESTDIR)$(libdir)/libdvdnavmini.la
	@sed -e 's%-I$(DESTDIR)$(includedir)%-I$${includedir}%g' -i $(DESTDIR)$(libdir)/pkgconfig/dvdnavmini.pc
	@rm -f $(DESTDIR)$(bindir)-config/dvdnav-config
	@rm -f $(DESTDIR)$(bindir)-config/$(compiler_prefix)dvdnav-config
	@mkdir -p $(DESTDIR)$(bindir)-config
	@mv $(DESTDIR)$(bindir)/dvdnav-config $(DESTDIR)$(bindir)-config/dvdnav-config
	@$(if $(compiler_prefix), ln -s dvdnav-config $(DESTDIR)$(bindir)-config/$(compiler_prefix)dvdnav-config)
	@$(MAKECOOKIE)
