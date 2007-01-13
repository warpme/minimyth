GARNAME = minimyth
GARVERSION = $(mm_VERSION)
CATEGORIES = meta

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
	devel/gdb \
	disk/hdparm \
	X11/intel \
	system/lcdproc \
	kernel/linux kernel/alsa-driver kernel/drm kernel/nvidia kernel/unionfs kernel/vt1211 \
	lirc/lirc \
	utils/lm_sensors \
	utils/lsdvd \
	kernel/module-init-tools \
	net/mount.cifs \
	mediaplayers/mplayer \
	myth/mythplugins-$(mm_MYTH_VERSION) \
	myth/mythstream \
	myth/myththemes-$(mm_MYTH_VERSION) \
	myth/mythtv-$(mm_MYTH_VERSION) \
	net/ntp \
	X11/nvidia \
	utils/pciutils \
	net/portmap \
	system/powernowd \
	qt/qt \
	X11/ratpoison \
	utils/regionset \
	X11/rxvt \
	system/splashutils \
	devel/strace \
	system/sysvinit \
	utils/transcode \
	system/udev \
	utils/usbutils \
	utils/util-linux \
	net/wakelan \
	net/webfs \
	X11/x11vnc \
	xorg/xorg \
	mediaplayers/xine-ui \
	system/zoneinfo \
	$(addprefix extras/,$(filter-out Makefile extras-% extras.%, $(shell cd ../../extras ; ls))) \
	$(mm_USER_PACKAGES)
BUILDDEPS = \
	utils/coreutils \
	devel/fakeroot \
	utils/file \
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

distro:
	@make -s -f minimyth.mk mm-make-distro DESTIMG=$(DESTIMG)
