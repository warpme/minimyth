GARNAME = alsa-lib
GARVERSION = $(ALSA_VERSION)
CATEGORIES = lib
MASTER_SITES = ftp://ftp.alsa-project.org/pub/lib/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = LGPL2_1

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c kernel/alsa-driver

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-static \
	--enable-shared \
	--with-gnu-ld

GAR_EXTRA_CONF += kernel/alsa-driver/package-api.mk
include ../../gar.mk

# The default STAGE_EXPORTS includes libdir, which confuses libtool.
STAGE_EXPORTS := $(filter-out libdir, $(STAGE_EXPORTS))

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
	@rm -f $(DESTDIR)$(libdir)/libasound.la
	@rm -f $(DESTDIR)$(libdir)/alsa-lib/smixer/smixer-sbase.la
	@rm -f $(DESTDIR)$(libdir)/alsa-lib/smixer/smixer-ac97.la
	@rm -f $(DESTDIR)$(libdir)/alsa-lib/smixer/smixer-hda.la
	@sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'         $(DESTDIR)$(libdir)/pkgconfig/alsa.pc
	@sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g' $(DESTDIR)$(libdir)/pkgconfig/alsa.pc
	@$(MAKECOOKIE)
