GARNAME = gettext
GARVERSION = 0.14.6
CATEGORIES = devel
MASTER_SITES = ftp://ftp.gnu.org/gnu/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/expat

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--with-gnu-ld

include ../../gar.mk

pre-configure:
	@# Libtool wants to hardcode library paths. sed 1 stops that unwanted behavior.
	@# Libtool wants to modify the library run path. sed 2 stops that unwanted behavior.
	@# Libtool wants search system directories rather than DESTIMG directories. sed 3 and 4 stop that unwanted behavior.
	@for file in `find $(WORKSRC) -name configure` ; do \
		sed -i 's%^hardcode_libdir_flag_spec=.*%hardcode_libdir_flag_spec=%'   $${file} ; \
		sed -i 's%^runpath_var=.*%runpath_var=%'                               $${file} ; \
		sed -i 's%^sys_lib_dlsearch_path_spec=.*%sys_lib_dlsearch_path_spec=%' $${file} ; \
		sed -i 's%^sys_lib_search_path_spec=.*%sys_lib_search_path_spec=%'     $${file} ; \
	 done
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libasprintf.la
	@rm -f $(DESTDIR)$(libdir)/libgettextlib.la
	@rm -f $(DESTDIR)$(libdir)/libgettextsrc.la
	@rm -f $(DESTDIR)$(libdir)/libgettextpo.la
	@$(MAKECOOKIE)
