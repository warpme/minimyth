GARNAME = udev
GARVERSION = 165
CATEGORIES = system
MASTER_SITES = ftp://ftp.kernel.org/pub/linux/utils/kernel/hotplug/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS   = lang/c gtk/glib lib/libacl lib/libusb-compat lib/libxslt utils/usbutils
BUILDDEPS = utils/gperf

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-silent-rules \
	--disable-static \
	--enable-shared \
	--disable-gtk-doc \
	--disable-gtk-doc-html \
	--disable-gtk-doc-pdf \
	--disable-debug \
	--enable-logging \
	--enable-extras \
	--disable-introspection \
	--with-gnu-ld \
	--with-rootlibdir=$(libdir) \
	--without-selinux \
	--with-firmware-path=$(elibdir)/firmware \
	--without-systemdsystemunitdir \
	--with-pci-ids-path=$(datadir)/pci.ids

include ../../gar.mk

sbindir    := $(esbindir)
libexecdir := $(elibdir)/udev

pre-configure:
	@$(call RUN_AUTOTOOLS)
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

pre-install:
	@rm -rf $(DESTDIR)$(sysconfdir)/udev
	@rm -rf $(DESTDIR)$(sbindir)/udevadm
	@rm -rf $(DESTDIR)$(sbindir)/udevd
	@rm -rf $(DESTDIR)$(libdir)/libgudev-1.0.*
	@rm -rf $(DESTDIR)$(libdir)/libudev.*
	@rm -rf $(DESTDIR)$(libdir)/pkgconfig/libudev.pc
	@rm -rf $(DESTDIR)$(libdir)/udev
	@$(MAKECOOKIE)

post-install:
	@rm -rf $(DESTDIR)$(libdir)/libgudev-1.0.la
	@rm -rf $(DESTDIR)$(libdir)/libudev.la
	@$(MAKECOOKIE)