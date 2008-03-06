GARNAME = bluez-utils
GARVERSION = 3.28
CATEGORIES = utils
MASTER_SITES = http://bluez.sf.net/download/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-limits_h.patch
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

pre-configure:
	@# Libtool wants to hardcode library paths. This stops that unwanted behavior.
	@sed -i 's%^hardcode_libdir_flag_spec=.*%hardcode_libdir_flag_spec=%' $(WORKSRC)/configure
	@# Libtool wants to modify the library run path. This stops that unwanted behavior.
	@sed -i 's%^runpath_var=.*%runpath_var=%' $(WORKSRC)/configure
	@# Libtool wants search system directories rather than DESTIMG directories. This stops that unwanted behavior.
	@sed -i 's%^sys_lib_dlsearch_path_spec=.*%sys_lib_dlsearch_path_spec=%' $(WORKSRC)/configure
	@sed -i 's%^sys_lib_search_path_spec=.*%sys_lib_search_path_spec=%' $(WORKSRC)/configure
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/alsa-lib/libasound_module_ctl_bluetooth.la
	@rm -f $(DESTDIR)$(libdir)/alsa-lib/libasound_module_pcm_bluetooth.la
	@$(MAKECOOKIE)
