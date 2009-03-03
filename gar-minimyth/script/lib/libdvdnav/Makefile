GARNAME = libdvdnav
GARVERSION = $(DVDNAV_TRUNK_VERSION)
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
	--with-gnu-ld \
	--with-dvdread-config="$(DESTDIR)$(bindir)/dvdread-config"

include ../../gar.mk

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
	@$(MAKECOOKIE)
