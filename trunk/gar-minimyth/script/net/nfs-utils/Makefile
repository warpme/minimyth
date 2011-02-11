GARNAME = nfs-utils
GARVERSION = 1.2.3
CATEGORIES = net
MASTER_SITES = http://downloads.sourceforge.net/project/nfs/$(GARNAME)/$(GARVERSION)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-dash.patch $(DISTNAME)-cross.patch
LICENSE = LGPL2_1

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lang/cxx utils/util-linux

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-nfsv3 \
	--disable-nfsv4 \
	--disable-nfsv41 \
	--disable-gss \
	--disable-kprefix \
	--enable-uuid \
	--enable-mount \
	--disable-tirpc \
	--enable-shared \
	--disable-static \
	--without-tcp-wrappers \
	--with-gnu-ld \
	--without-krb5
CONFIGURE_ENV = \
	CFLAGS_FOR_BUILD="$(build_CFLAGS)" \
	CXXFLAGS_FOR_BUILD="$(build_CXXFLAGS)" \
	CPPFLAGS_FOR_BUILD="$(build_CPPFLAGS)" \
	LDFLAGS_FOR_BUILD="$(build_LDFLAGS)" \
	libblkid_cv_is_recent="yes"

include ../../gar.mk

pre-configure:
	@$(call RUN_AUTOTOOLS)
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

x-post-install:
	@chmod 755 $(DESTDIR)$(esbindir)/mount.nfs
	@$(MAKECOOKIE)
