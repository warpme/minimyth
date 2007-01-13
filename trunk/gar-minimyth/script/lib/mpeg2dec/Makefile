GARNAME = mpeg2dec
GARVERSION = 0.4.0
CATEGORIES = lib
MASTER_SITES = http://libmpeg2.sourceforge.net/files/
DISTFILES = $(DISTNAME)b.tar.gz
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS   = lang/c lib/SDL xorg/xorg
BUILDDEPS = devel/nasm

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes=$(DESTDIR)$(includedir) \
	--x-libraries=$(DESTDIR)$(libdir) \
	--enable-shared \
	--enable-static \
	--with-gnu-ld \
	--with-x \
	$(if $(filter i386,$(GARCH_FAMILY)),,--disable-accel-detect)

CONFIGURE_ENV = \
	SDLCONFIG="$(DESTDIR)$(bindir)/sdl-config"

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

post-install:
	rm -f $(DESTDIR)$(libdir)/libmpeg2.la
	rm -f $(DESTDIR)$(libdir)/libmpeg2convert.la
	@sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'         $(DESTDIR)$(libdir)/pkgconfig/libmpeg2.pc
	@sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g' $(DESTDIR)$(libdir)/pkgconfig/libmpeg2.pc
	@sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'         $(DESTDIR)$(libdir)/pkgconfig/libmpeg2convert.pc
	@sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g' $(DESTDIR)$(libdir)/pkgconfig/libmpeg2convert.pc
	@$(MAKECOOKIE)
