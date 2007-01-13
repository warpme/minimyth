GARNAME = libdvdcss
GARVERSION = 1.2.8
CATEGORIES = extras
MASTER_SITES = http://download.videolan.org/pub/$(GARNAME)/$(GARVERSION)/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(EXTRAS_DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--with-gnu-ld

include ../../gar.mk
include ../extras.mk

post-patch:
	@# Libtool wants to hardcode library paths. This stops that unwanted behavior.
	@sed -i 's%^hardcode_libdir_flag_spec=.*%hardcode_libdir_flag_spec=%' $(WORKSRC)/configure
	@# Libtool wants to modify the library run path. This stops that unwanted behavior.
	@sed -i 's%^runpath_var=.*%runpath_var=%' $(WORKSRC)/configure
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(extras_libdir)/libdvdcss.la
	@$(MAKECOOKIE)
