GARNAME = minimyth
GARVERSION = $(mm_VERSION)
CATEGORIES = meta
LICENSE = minimyth
minimyth_LICENSE_TEXT = $(mm_HOME)/html/minimyth/license.txt

DESCRIPTION =
define BLURB
endef

MINIMYTHIMG = main

DESTIMG = $(MINIMYTHIMG)

DEPENDS = \
	system/acpid \
 	utils/alsa-utils \
	utils/busybox \
	utils/dmidecode \
	utils/ethtool \
	devel/gdb \
	disk/hdparm \
	system/lcdproc \
	kernel/linux kernel/alsa-driver kernel/drm kernel/unionfs kernel/vt1211 \
	lirc/lirc \
	utils/lm_sensors \
	utils/lsdvd \
	kernel/module-init-tools \
	net/mount.cifs \
	mediaplayers/mplayer \
	myth/mythplugins-$(mm_MYTH_VERSION) \
	myth/mythstream-$(mm_MYTH_VERSION) \
	myth/myththemes-$(mm_MYTH_VERSION) \
	myth/mythtv-$(mm_MYTH_VERSION) \
	net/ntp \
	nvidia/nvidia-$(mm_NVIDIA_VERSION) \
	utils/pciutils \
	net/portmap \
	system/powernowd \
	qt/qt \
	X11/ratpoison \
	utils/regionset \
	X11/rxvt \
	system/splashutils \
	utils/squashfs \
	devel/strace \
	system/sysvinit \
	utils/transcode \
	system/udev \
	utils/usbutils \
	utils/util-linux \
	devel/valgrind \
	net/wakelan \
	net/webfs \
	X11/x11vnc \
	xorg/xorg \
	mediaplayers/xine-ui \
	X11/xscreensaver \
	system/zoneinfo \
	$(addprefix extras/,$(filter-out Makefile extras-% extras.%, $(shell cd ../../extras ; ls))) \
	$(mm_USER_PACKAGES)
BUILDDEPS = \
	utils/coreutils \
	devel/fakeroot \
	utils/file \
	utils/findutils \
	utils/squashfs \
	utils/tar \
	utils/util-linux \
	xorg/xorg

BUILD_SCRIPTS   = custom
INSTALL_SCRIPTS = custom

include ../../gar.mk

pre-fetch:
	@make -s -f minimyth.mk mm-check DESTIMG=$(DESTIMG)
	@$(MAKECOOKIE)

build-custom:
	@make -s -f minimyth.mk mm-build DESTIMG=$(DESTIMG)
	@$(MAKECOOKIE)

install-custom:
	@make -s -f minimyth.mk mm-install DESTIMG=$(DESTIMG)
