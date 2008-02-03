GARNAME = bluez-utils
GARVERSION = 3.25
CATEGORIES = utils
MASTER_SITES = http://bluez.sf.net/download/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/alsa-lib lib/bluez-libs lib/dbus lib/expat lib/libsndfile lib/libusb

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-debug \
	--enable-inotify \
	--enable-expat \
	--disable-hal \
	--enable-usb \
	--enable-alsa \
	--disable-obex \
	--disable-glib \
	--disable-gstreamer \
	--enable-audio \
	--enable-input \
	--enable-network \
	--disable-sync \
	--enable-echo \
	--enable-hcid \
	--enable-sdpd \
	--enable-hidd \
	--enable-pand \
	--disable-test \
	--disable-cups \
	--enable-manpages \
	--enable-configfiles \
	--enable-initscripts \
	--enable-pcmciarules \
	--enable-pcmciarules \
	--enable-bccmd \
	--enable-avctrl \
	--enable-hid2hci \
	--enable-dfutool \
	--enable-dfubabel \
	--with-gnu-ld

include ../../gar.mk

post-install:
	@rm -f $(DESTDIR)$(libdir)/alsa-lib/libasound_module_ctl_bluetooth.la
	@rm -f $(DESTDIR)$(libdir)/alsa-lib/libasound_module_pcm_bluetooth.la
	@$(MAKECOOKIE)
