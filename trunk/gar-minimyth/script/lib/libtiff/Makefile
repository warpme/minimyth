GARNAME = tiff
GARVERSION = 3.7.3
CATEGORIES = lib
MASTER_SITES  = http://fresh.t-systems-sfr.com/unix/src/misc/
MASTER_SITES += ftp://ftp.remotesensing.org/pub/libtiff/
MASTER_SITES += ftp://ftp.remotesensing.org/pub/libtiff/old/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = libtiff
libtiff_LICENSE_TEXT = $(WORKSRC)/COPYRIGHT

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/zlib lib/libjpeg

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--with-gnu-ld \
	--without-x

include ../../gar.mk

post-patch:
	@# Libtool wants to hardcode library paths. This stops that unwanted behavior.
	@sed -i 's%^hardcode_libdir_flag_spec=.*%hardcode_libdir_flag_spec=%' $(WORKSRC)/configure
	@# Libtool wants to modify the library run path. This stops that unwanted behavior.
	@sed -i 's%^runpath_var=.*%runpath_var=%' $(WORKSRC)/configure
	@# Libtool wants search system directories rather than DESTIMG directories. This stops that unwanted behavior.
	@sed -i 's%^sys_lib_dlsearch_path_spec=.*%sys_lib_dlsearch_path_spec=%' $(WORKSRC)/configure
	@sed -i 's%^sys_lib_search_path_spec=.*%sys_lib_search_path_spec=%' $(WORKSRC)/configure
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libtiff.la
	@rm -f $(DESTDIR)$(libdir)/libtiffxx.la
	@$(MAKECOOKIE)
