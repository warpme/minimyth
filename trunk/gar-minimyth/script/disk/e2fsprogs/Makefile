GARNAME = e2fsprogs
GARVERSION = 1.41.4
CATEGORIES = disk
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-chmod.patch $(DISTNAME)-verbose.patch
LICENSE = GPL2/LGPL2

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
	@$(call FIX_LIBTOOL_LIBPATH,$(WORKSRC),configure)
	@$(MAKECOOKIE)

install-custom:
	@$(INSTALL_ENV) $(MAKE) DESTDIR=$(DESTDIR) $(foreach TTT,$(INSTALL_OVERRIDE_DIRS),$(TTT)="$(DESTDIR)$($(TTT))") -C $(WORKSRC) $(INSTALL_ARGS) install install-libs
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libblkid.a
	@rm -f $(DESTDIR)$(libdir)/libcom_err.a
	@rm -f $(DESTDIR)$(libdir)/libe2p.a
	@rm -f $(DESTDIR)$(libdir)/libext2fs.a
	@rm -f $(DESTDIR)$(libdir)/libss.a
	@rm -f $(DESTDIR)$(libdir)/libuuid.a
	@mv -f $(DESTDIR)$(libdir)/libblkid.* $(DESTDIR)$(elibdir)/
	@mv -f $(DESTDIR)$(libdir)/libuuid.*  $(DESTDIR)$(elibdir)/
	@$(MAKECOOKIE)
