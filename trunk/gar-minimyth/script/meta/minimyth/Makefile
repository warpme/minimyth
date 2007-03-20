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
        X11/corefonts \
	utils/dmidecode \
	utils/ethtool \
	devel/fakeroot \
	emulators/fceu \
	devel/gdb \
	disk/hdparm \
	X11/IEGD \
	emulators/jzintv \
	system/lcdproc \
	system/kbdd \
	kernel/kernel \
	system/lirc \
	utils/lm_sensors \
	utils/lsdvd \
	utils/module-init-tools \
	net/mount.cifs \
	mediaplayers/mplayer \
	myth-$(mm_MYTH_VERSION)/myth \
	net/ntp \
	nvidia/nvidia-$(mm_NVIDIA_VERSION) \
	utils/pciutils \
	net/portmap \
	system/powernowd \
	qt/qt \
	X11/ratpoison \
	utils/regionset \
	X11/rxvt \
        utils/SDL-Test \
	system/splashutils \
	utils/squashfs \
	emulators/stella \
	devel/strace \
	system/sysvinit \
	utils/transcode \
	X11/ttf-bitstream-vera \
	system/udev \
	utils/usbutils \
	utils/util-linux-ng \
	devel/valgrind \
	emulators/VisualBoyAdvance \
	net/wakelan \
	net/webfs \
	X11/x11vnc \
	mediaplayers/xine-ui \
	X11/xmacro \
	xorg/xorg \
	X11/xscreensaver \
	X11/xvattr \
	system/zoneinfo \
	emulators/zsnes \
	$(addprefix extras/,$(filter-out Makefile extras-% extras.%, $(shell cd ../../extras ; ls))) \
	$(mm_USER_PACKAGES)
BUILDDEPS = \
	utils/coreutils \
	devel/fakeroot \
	utils/file \
	utils/findutils \
	utils/squashfs \
	utils/tar \
	utils/util-linux-ng \
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
