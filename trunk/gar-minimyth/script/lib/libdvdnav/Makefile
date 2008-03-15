GARNAME = libdvdnav
GARVERSION = 997
CATEGORIES = lib
MASTER_SITES = svn://svn.mplayerhq.hu/dvdnav/trunk/libdvdnav/
DISTFILES = $(DISTNAME).tar.bz2
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

svn//%/$(DISTNAME).tar.bz2:
	@$(call FETCH_SVN, svn://$*, $(GARVERSION), $(DISTNAME))
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

pre-configure:
	@cd $(WORKSRC) ; ln -s configure2 configure
	@$(MAKECOOKIE)

post-configure:
	@sed -e 's%^DESTDIR *= *.*$$%DESTDIR=$(DESTDIR)%' -i $(WORKSRC)/config.mak
	@$(MAKECOOKIE)
