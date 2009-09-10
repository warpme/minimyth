GARNAME = bluez
GARVERSION = 4.53
CATEGORIES = lib
MASTER_SITES = http://www.kernel.org/pub/linux/bluetooth/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c gtk/glib lib/alsa-lib lib/dbus lib/expat lib/libsndfile lib/libusb-compat

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-silent-rules \
	--disable-static \
	--enable-shared \
	--disable-gtk-doc \
	--enable-fortify \
	--disable-pie \
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
	--enable-pcmcia \
	--enable-hid2hci \
	--enable-dfutool \
	--enable-hidd \
	--enable-pand \
	--enable-dund \
	--disable-cups \
	--disable-test \
	--enable-manpages \
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
