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
	fonts/corefonts \
	utils/dmidecode \
	net/dropbear \
	disk/eject \
	utils/ethtool \
	devel/fakeroot \
	disk/hdparm \
	system/lcdproc \
	system/kbdd \
	kernel/kernel \
	system/lirc \
	utils/lm_sensors \
	utils/lsdvd \
	utils/module-init-tools \
	net/mount.cifs \
	myth/myth \
	net/ntp \
	utils/pciutils \
	utils/pmount \
	net/portmap \
	system/powernowd \
	qt/qt \
	X11/ratpoison \
	utils/regionset \
	X11/rxvt \
	utils/SDL-Test \
	system/splashutils \
	utils/squashfs \
	system/sysvinit \
	fonts/ttf-bitstream-vera \
	system/udev \
	utils/usbutils \
	utils/util-linux-ng \
	net/wakelan \
	net/webfs \
	X11/x11vnc \
	X11/xmacro \
	xorg/xorg \
	X11/xscreensaver \
	X11/xvattr \
	system/zoneinfo \
	$(if $(filter iegd,$(mm_CHIPSETS)), \
		$(if $(filter 2.6.17,$(mm_KERNEL_VERSION)),X11/IEGD)) \
	$(if $(filter nvidia,$(mm_CHIPSETS)), \
		nvidia/nvidia) \
	$(if $(filter mythgame,$(mm_SOFTWARE)), \
		emulators/fceu \
		emulators/jzintv \
		emulators/stella \
		emulators/VisualBoyAdvance \
		emulators/zsnes) \
	$(if $(filter mplayer,$(mm_SOFTWARE)), \
		mediaplayers/mplayer) \
	$(if $(filter xine,$(mm_SOFTWARE)), \
		mediaplayers/xine-ui) \
	$(if $(filter transcode,$(mm_SOFTWARE)), \
		utils/transcode) \
	$(if $(filter debug,$(mm_SOFTWARE)), \
		devel/gdb \
		devel/strace \
		devel/valgrind) \
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
