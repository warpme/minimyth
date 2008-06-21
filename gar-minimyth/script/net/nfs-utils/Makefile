GARNAME = nfs-utils
GARVERSION = 1.1.0
CATEGORIES = net
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/nfs/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-nolock.patch $(DISTNAME)-cross.patch
LICENSE = LGPL2_1

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c disk/e2fsprogs

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-nfsv3 \
	--disable-nfsv4 \
	--disable-gss \
	--disable-kprefix \
	--with-uuid \
	--enable-mount \
	--without-tcp-wrappers \
	--with-gnu-ld \
	--without-krb5
CONFIGURE_ENV = \
	CFLAGS_FOR_BUILD="$(build_CFLAGS)" \
	CXXFLAGS_FOR_BUILD="$(build_CXXFLAGS)" \
	CPPFLAGS_FOR_BUILD="$(build_CPPFLAGS)" \
	LDFLAGS_FOR_BUILD="$(build_LDFLAGS)" \
	libblkid_is_recent="yes"

include ../../gar.mk

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@chmod 755 $(DESTDIR)$(esbindir)/mount.nfs
	@$(MAKECOOKIE)
