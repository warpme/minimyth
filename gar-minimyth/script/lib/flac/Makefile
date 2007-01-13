GARNAME = flac
GARVERSION = 1.1.1
CATEGORIES = lib
MASTER_SITES = http://voxel.dl.sourceforge.net/sourceforge/flac/
DISTFILES = $(DISTNAME).tar.gz
LICENSE =

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/libogg
BUILDDEPS = devel/nasm

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--with-ogg-includes=$(DESTDIR)$(includedir) \
	--with-ogg-libraries=$(DESTDIR)$(libdir) \
	--disable-oggtest

CONFIGURE_ENV  = \
        PKG_CONFIG_PATH="$(DESTDIR)$(libdir)/pkgconfig:$(DESTDIR)$(x11libdir)/pkgconfig:$(DESTDIR)$(qtlibdir)/pkgconfig"

include ../../gar.mk

# Libtool insists on relinking during install and including -L$(libdir) when relinking.
# This causes -L$(DESTDIR)$(libdir) to appear first so the right libraries get linked during relinking.
CFLAGS  += -L$(DESTDIR)$(libdir)
LDFLAGS += -L$(DESTDIR)$(libdir)

post-patch:
	@# Libtool wants to hardcode library paths. This stops that unwanted behavior.
	@sed -i 's%^hardcode_libdir_flag_spec=.*%hardcode_libdir_flag_spec=%' $(WORKSRC)/configure
	@# Libtool wants to modify the library run path. This stops that unwanted behavior.
	@sed -i 's%^runpath_var=.*%runpath_var=%' $(WORKSRC)/configure
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libFLAC.la
	@rm -f $(DESTDIR)$(libdir)/libFLAC++.la
	@rm -f $(DESTDIR)$(libdir)/libOggFLAC.la
	@rm -f $(DESTDIR)$(libdir)/libOggFLAC++.la
	@$(MAKECOOKIE)
