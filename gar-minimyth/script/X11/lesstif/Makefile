GARNAME = lesstif
GARVERSION = 0.94.4
CATEGORIES = X11
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME).patch.gar $(DISTNAME)-aclocal.patch $(DISTNAME)-ac_path_prog.patch $(DISTNAME)-m4_includes.patch
LICENSE =

DESCRIPTION =
define BLURB
endef

DEPENDS   = lang/c xorg/xorg 
ifneq ($(DESTIMG),build)
BUILDDEPS = X11/lesstif
endif

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes=$(DESTDIR)$(includedir) \
	--x-libraries=$(DESTDIR)$(libdir) \
	--with-gnu-ld \
	--with-x \
	--without-motif \
	--with-freetype-config=$(DESTDIR)$(bindir)/freetype-config \
	--without-fontconfig-config \
	--without-fontconfig-includes \
	--without-fontconfig-lib

BUILD_ARGS     = \
	rootdir="$(docdir)/$(DISTNAME)"
INSTALL_ARGS   = \
	rootdir="$(docdir)/$(DISTNAME)"

CONFIGURE_ENV  = \
	$(if $(filter-out build,$(DESTIMG)),man2html_cmd=$(build_DESTDIR)$(build_bindir)/$(GARNAME)-man2html)

include ../../gar.mk

post-patch:
	@cd $(WORKSRC) ; aclocal
	@cd $(WORKSRC) ; libtoolize --copy --force
	@cd $(WORKSRC) ; autoconf
	@# Libtool wants to hardcode library paths. This stops that unwanted behavior.
	@sed -i 's%^hardcode_libdir_flag_spec=.*%hardcode_libdir_flag_spec=%' $(WORKSRC)/configure
	@# Libtool wants to modify the library run path. This stops that unwanted behavior.
	@sed -i 's%^runpath_var=.*%runpath_var=%' $(WORKSRC)/configure
	@# Libtool wants search system directories rather than DESTIMG directories. This stops that unwanted behavior.
	@sed -i 's%^sys_lib_dlsearch_path_spec=.*%sys_lib_dlsearch_path_spec=%' $(WORKSRC)/configure
	@sed -i 's%^sys_lib_search_path_spec=.*%sys_lib_search_path_spec=%' $(WORKSRC)/configure
	@$(MAKECOOKIE)

post-install:
	@$(if $(filter build,$(DESTIMG)),cp -f $(WORKSRC)/scripts/man2html $(DESTDIR)$(bindir)/$(GARNAME)-man2html)
	@rm -f $(DESTDIR)$(libdir)/libXm.la
	@rm -f $(DESTDIR)$(libdir)/libMrm.la
	@rm -f $(DESTDIR)$(libdir)/libUil.la
	@$(MAKECOOKIE)
