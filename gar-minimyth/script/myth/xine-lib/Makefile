GARNAME = xine-lib
GARVERSION = 1.0
CATEGORIES = myth
MASTER_SITES = http://unc.dl.sourceforge.net/sourceforge/xine/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-DESTDIR.patch
LICENSE = 

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c kernel/linux lib/alsa-lib lib/flac lib/libogg lib/libvorbis X11/X11 X11/freetype

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ENV = \
	PKG_CONFIG_PATH="$(DESTDIR)$(libdir)/pkgconfig:$(DESTDIR)$(x11libdir)/pkgconfig:$(DESTDIR)$(qtlibdir)/pkgconfig"

# The configure program does not deal well with cross compiling,
# so we do not include --build or --host and we let CC set the compiler.
# Since both the the build and the host are i386, this works.
CONFIGURE_ARGS = $(DIRPATHS) \
	--x-includes=$(DESTDIR)$(x11includedir) \
	--x-libraries=$(DESTDIR)$(x11libdir) \
	--disable-altivec \
	--disable-vis \
	--disable-mlib \
	--enable-ipv6 \
	--disable-fb \
	--disable-sdltest \
	--disable-dxr3 \
	--disable-vidix \
	--with-gnu-ld \
	--with-x \
	--with-xxmc-lib=viaXvMC

include ../../gar.mk

CFLAGS := $(CFLAGS) -Wl,-rpath-link,$(DESTDIR)$(x11libdir)

post-patch:
	@# Libtool wants to hardcode library paths. This stops that unwanted behavior.
	@sed -i 's%^hardcode_libdir_flag_spec=.*%hardcode_libdir_flag_spec=%' $(WORKSRC)/configure
	@# Libtool wants to modify the library run path. This stops that unwanted behavior.
	@sed -i 's%^runpath_var=.*%runpath_var=%' $(WORKSRC)/configure
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libxine.la
	@$(MAKECOOKIE)
