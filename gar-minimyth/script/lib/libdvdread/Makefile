GARNAME = libdvdread
GARVERSION = 0.9.5
CATEGORIES = lib
MASTER_SITES = http://www.dtek.chalmers.se/groups/dvd/dist/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-inttypes_h.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--with-gnu-ld

include ../../gar.mk

pre-configure:
	@# Libtool wants to hardcode library paths. This stops that unwanted behavior.
	@sed -i 's%^hardcode_libdir_flag_spec=.*%hardcode_libdir_flag_spec=%' $(WORKSRC)/configure
	@# Libtool wants to modify the library run path. This stops that unwanted behavior.
	@sed -i 's%^runpath_var=.*%runpath_var=%' $(WORKSRC)/configure
	@# Libtool wants search system directories rather than DESTIMG directories. This stops that unwanted behavior.
	@sed -i 's%^sys_lib_dlsearch_path_spec=.*%sys_lib_dlsearch_path_spec=%' $(WORKSRC)/configure
	@sed -i 's%^sys_lib_search_path_spec=.*%sys_lib_search_path_spec=%' $(WORKSRC)/configure
	@$(MAKECOOKIE)

post-configure:
	@# This, in conjunction with the $(DISTNAME)-inttypes_h.patch file,
	@# include the appropiate inttypes.h and stdint.h headers
	@# so that programs using libdvdread do not need to.
	@if [ -n "`cat $(WORKSRC)/config.h | grep '^#define HAVE_INTTYPES_H 1'`" ] ; then \
		sed -i 's%@INCLUDE_INTTYPES_H@%#include <inttypes.h>%' $(WORKSRC)/dvdread/ifo_types.h ; \
	 else \
		sed -i 's%@INCLUDE_INTTYPES_H@%%'                      $(WORKSRC)/dvdread/ifo_types.h ; \
	 fi
	@if [ -n "`cat $(WORKSRC)/config.h | grep '^#define HAVE_STDINT_H 1'`"   ] ; then \
		sed -i 's%@INCLUDE_STDINT_H@%#include <stdint.h>%'     $(WORKSRC)/dvdread/ifo_types.h ; \
	 else \
		sed -i 's%@INCLUDE_STDINT_H@%%'                        $(WORKSRC)/dvdread/ifo_types.h ; \
	 fi
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libdvdread.la
	@$(MAKECOOKIE)
