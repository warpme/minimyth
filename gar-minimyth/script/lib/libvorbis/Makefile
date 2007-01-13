GARNAME = libvorbis
GARVERSION = 1.1.0
CATEGORIES = lib
MASTER_SITES = http://downloads.xiph.org/releases/vorbis/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = xiph
xiph_LICENSE_TEXT = $(WORKSRC)/COPYING

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/libogg

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-fast-install

CONFIGURE_ENV  = \
	PKG_CONFIG_PATH="$(DESTDIR)$(libdir)/pkgconfig:$(DESTDIR)$(x11libdir)/pkgconfig:$(DESTDIR)$(qtlibdir)/pkgconfig"

xINSTALL_OVERRIDE_DIRS = libdir

include ../../gar.mk

# Libtool insists on relinking during install and including -L$(libdir) when relinking.
# This causes -L$(DESTDIR)$(libdir) to appear first so the right libraries get linked during relinking.
CFLAGS  += -L$(DESTDIR)$(libdir)
LDFLAGS += -L$(DESTDIR)$(libdir)

# Libtool wants to hardcode library paths.
# This stops that evil behavior.
post-patch:
	@sed -i 's%^hardcode_libdir_flag_spec=.*%hardcode_libdir_flag_spec=%' $(WORKSRC)/configure
	@$(MAKECOOKIE)

post-install:
	rm -f $(DESTDIR)$(libdir)/libvorbis.la
	rm -f $(DESTDIR)$(libdir)/libvorbisenc.la
	rm -f $(DESTDIR)$(libdir)/libvorbisfile.la
	@sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'         $(DESTDIR)$(libdir)/pkgconfig/vorbisenc.pc
	@sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g' $(DESTDIR)$(libdir)/pkgconfig/vorbisenc.pc
	@sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'         $(DESTDIR)$(libdir)/pkgconfig/vorbisfile.pc
	@sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g' $(DESTDIR)$(libdir)/pkgconfig/vorbisfile.pc
	@sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'         $(DESTDIR)$(libdir)/pkgconfig/vorbis.pc
	@sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g' $(DESTDIR)$(libdir)/pkgconfig/vorbis.pc
	@$(MAKECOOKIE)
