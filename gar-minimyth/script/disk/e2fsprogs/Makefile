GARNAME = e2fsprogs
GARVERSION = 1.40.4
CATEGORIES = disk
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME).patch $(DISTNAME)-configure.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = custom

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-rpath \
	--enable-elf-shlibs \
	--with-gnu-ld

include ../../gar.mk

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(MAKECOOKIE)

install-custom:
	@$(INSTALL_ENV) $(MAKE) DESTDIR=$(DESTDIR) $(foreach TTT,$(INSTALL_OVERRIDE_DIRS),$(TTT)="$(DESTDIR)$($(TTT))") -C $(WORKSRC) $(INSTALL_ARGS) install install-libs
	@$(MAKECOOKIE)

post-install:
	@mv -f $(DESTDIR)$(libdir)/libblkid.* $(DESTDIR)$(elibdir)/
	@mv -f $(DESTDIR)$(libdir)/libuuid.*  $(DESTDIR)$(elibdir)/
	@$(call CREATE_PKG_CONFIG_UNINSTALLED,$(libdir)/pkgconfig,blkid)
	@$(call CREATE_PKG_CONFIG_UNINSTALLED,$(libdir)/pkgconfig,com_err)
	@$(call CREATE_PKG_CONFIG_UNINSTALLED,$(libdir)/pkgconfig,ext2fs)
	@$(call CREATE_PKG_CONFIG_UNINSTALLED,$(libdir)/pkgconfig,e2p)
	@$(call CREATE_PKG_CONFIG_UNINSTALLED,$(libdir)/pkgconfig,ss)
	@$(call CREATE_PKG_CONFIG_UNINSTALLED,$(libdir)/pkgconfig,uuid)
	@$(MAKECOOKIE)
