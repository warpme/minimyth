GARNAME = util-linux
GARVERSION = 2.26.2
CATEGORIES = utils
MASTER_SITES = https://www.kernel.org/pub/linux/utils/util-linux/v2.26/
DISTFILES = $(DISTNAME).tar.xz
PATCHFILES = $(DISTNAME)-agetty_2.19.1.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

# util-linux 2.22.2 fails checking for ncurses headers before checking for ncursesw library.
DEPENDS = lang/c lib/ncurses lib/ncursesw lib/zlib

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--bindir=$(ebindir) \
	--sbindir=$(esbindir) \
	--libdir=$(elibdir) \
	--cache-file=config.cache \
	--disable-silent-rules \
	--enable-shared \
	--disable-static \
	--disable-gtk-doc \
	--enable-nls \
	--disable-rpath \
	--disable-all-programs \
	--enable-tls \
	--enable-libuuid \
	--enable-libblkid \
	--enable-libmount \
	--enable-mount \
	--enable-uuidd \
	--enable-agetty \
	--enable-cramfs \
	--enable-switch-root \
	--enable-rename \
	--enable-chsh-only-listed \
	--enable-pg-bell \
	--with-gnu-ld \
	--without-selinux \
	--without-audit \
	--without-udev \
	--without-slang \
	--without-utempter \
	--without-user \
	--without-systemd \
	--without-smack \
	--without-python

BUILD_ARGS     = \
	usrbin_execdir=$(bindir) \
	usrsbin_execdir=$(sbindir) \
	usrlib_execdir=$(elibdir) \
	pkgconfigdir=$(libdir)/pkgconfig
INSTALL_ARGS   = \
	usrbin_execdir=$(bindir) \
	usrsbin_execdir=$(sbindir) \
	usrlib_execdir=$(elibdir) \
	pkgconfigdir=$(libdir)/pkgconfig

include ../../gar.mk

pre-configure:
	@$(call RUN_GETTEXTIZE)
	@$(call RUN_AUTOTOOLS)
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(if $(filter-out build,$(DESTIMG)),echo "scanf_cv_alloc_modifier=ms" >> $(WORKSRC)/config.cache)
	@$(if $(filter-out build,$(DESTIMG)),echo "ax_cv_have_tls=yes"         >> $(WORKSRC)/config.cache)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(elibdir)/libblkid.la
	@rm -f $(DESTDIR)$(elibdir)/libmount.la
	@rm -f $(DESTDIR)$(elibdir)/libuuid.la
	@$(MAKECOOKIE)
