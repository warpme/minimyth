GARNAME = bluez
GARVERSION = 4.62
CATEGORIES = lib
MASTER_SITES = http://www.kernel.org/pub/linux/bluetooth/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-ps3remote_20091128.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c gtk/glib lib/dbus lib/expat lib/libusb-compat

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-silent-rules \
	--disable-static \
	--enable-shared \
	--enable-fortify \
	--disable-pie \
	--disable-capng \
	--disable-network \
	--disable-serial \
	--enable-input \
	--disable-audio \
	--enable-service \
	--disable-gstreamer \
	--disable-alsa \
	--enable-usb \
	--disable-netlink \
	--enable-tools \
	--enable-bccmd \
	--enable-pcmcia \
	--enable-hid2hci \
	--enable-dfutool \
	--disable-hidd \
	--disable-pand \
	--disable-dund \
	--disable-cups \
	--disable-test \
	--enable-udevrules \
	--enable-configfiles \
	--disable-debug \
	--with-gnu-ld

include ../../gar.mk

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/alsa-lib/libasound_module_ctl_bluetooth.la
	@rm -f $(DESTDIR)$(libdir)/alsa-lib/libasound_module_pcm_bluetooth.la
	@rm -f $(DESTDIR)$(libdir)/libbluetooth.la
	@$(MAKECOOKIE)
