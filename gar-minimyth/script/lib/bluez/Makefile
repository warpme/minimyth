GARNAME = bluez
GARVERSION = 4.13
CATEGORIES = lib
MASTER_SITES = http://www.kernel.org/pub/linux/bluetooth/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/alsa-lib lib/dbus lib/expat lib/glib lib/libsndfile lib/libusb

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-network \
	--enable-serial \
	--enable-input \
	--enable-audio \
	--enable-service \
	--disable-gstreamer \
	--enable-alsa \
	--enable-usb \
	--enable-netlink \
	--enable-tools \
	--enable-bccmd \
	--enable-hid2hci \
	--enable-dfutool \
	--enable-hidd \
	--enable-pand \
	--enable-dund \
	--disable-cups \
	--disable-test \
	--enable-manpages \
	--enable-configfiles \
	--enable-initscripts \
	--enable-pcmciarules \
	--disable-debug \
	--with-gnu-ld

include ../../gar.mk

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/alsa-lib/libasound_module_ctl_bluetooth.la
	@rm -f $(DESTDIR)$(libdir)/alsa-lib/libasound_module_pcm_bluetooth.la
	@rm -f $(DESTDIR)$(libdir)/bluetooth/plugins/audio.la
	@rm -f $(DESTDIR)$(libdir)/bluetooth/plugins/input.la
	@rm -f $(DESTDIR)$(libdir)/bluetooth/plugins/hal.la
	@rm -f $(DESTDIR)$(libdir)/bluetooth/plugins/network.la
	@rm -f $(DESTDIR)$(libdir)/bluetooth/plugins/serial.la
	@rm -f $(DESTDIR)$(libdir)/bluetooth/plugins/service.la
	@rm -f $(DESTDIR)$(libdir)/libbluetooth.la
	@$(MAKECOOKIE)
