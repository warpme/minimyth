GARNAME = nfs-utils
GARVERSION = 1.2.7
CATEGORIES = net
MASTER_SITES = http://downloads.sourceforge.net/project/nfs/$(GARNAME)/$(GARVERSION)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-native_hack.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lang/cxx net/libtirpc utils/util-linux

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-nfsv4 \
	--disable-nfsv41 \
	--disable-gss \
	--disable-kprefix \
	--enable-uuid \
	--enable-mount \
	--enable-libmount-mount \
	--enable-tirpc \
	--disable-ipv6 \
	--disable-mountconfig \
	--disable-nfsdcltrack \
	--disable-caps \
	--enable-largefile \
	--enable-shared \
	--disable-static \
	--with-rpcgen=$(build_DESTDIR)$(build_bindir)/rpcgen \
	--with-tirpcinclude=$(DESTDIR)$(includedir)/tirpc \
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

# nfs-utils 1.2.7 fails to compile with gcc 5.2.0's link time optimization enabled.
CFLAGS  := $(filter-out -flto, $(CFLAGS))  -fno-lto
LDFLAGS := $(filter-out -flto, $(LDFLAGS)) -fno-lto

pre-configure:
	@$(call RUN_AUTOTOOLS)
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)
