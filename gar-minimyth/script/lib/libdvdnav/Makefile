GARNAME = libdvdnav
GARVERSION = 4.1.2
CATEGORIES = lib
MASTER_SITES = http://www.mplayerhq.hu/MPlayer/releases/dvdnav/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-dirpaths.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = \
	--prefix="$(prefix)" \
	--libdir="$(libdir)" \
	--shlibdir="$(libdir)" \
	--incdir="$(includedir)/dvdnav" \
	--enable-static \
	--enable-shared \
	--enable-debug \
	--without-dvdread \
	--cc="$(CC)" \
	--make="$(MAKE)" \
	--extra-cflags="$(CFLAGS)" \
	--extra-ldflags="$(LDFLAGS)" \
	--disable-strip \
	--disable-opts
BUILD_ARGS     = \
	AR="$(AR)" \
	LD="$(LD)" \
	RANLIB="$(RANLIB)"
INSTALL_ARGS   =

include ../../gar.mk

PARALLELMFLAGS := -j1

pre-configure:
	@cd $(WORKSRC) ; ln -s configure2 configure
	@$(MAKECOOKIE)

post-configure:
	@sed -e 's%^dvdread_incdir *= *.*$$%dvdread_incdir=$(includedir)/dvdread%' -i $(WORKSRC)/config.mak
	@$(MAKECOOKIE)
