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
	X11/aewm \
 	utils/alsa-utils \
	utils/busybox \
	devel/gdb \
	disk/hdparm \
	system/lcdproc \
	X11/libXvMCW \
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
	net/portmap \
	qt/qt \
	X11/rxvt \
	system/splashutils \
	utils/strace \
	system/sysvinit \
	system/udev \
	X11/unichrome \
	X11/unichrome_dri \
	utils/util-linux \
	net/webfs \
	X11/X11 \
	X11/x11vnc \
	mediaplayers/xine-ui \
	system/zoneinfo \
	$(addprefix extras/,$(filter-out Makefile extras-% extras.%, $(shell cd ../../extras ; ls)))
BUILDDEPS = \
	utils/util-linux

BUILD_SCRIPTS   = custom
INSTALL_SCRIPTS = custom

include ../../gar.mk

pre-fetch:
	@make -s -f minimyth.mk mm-check DESTIMG=$(DESTIMG)
	@$(MAKECOOKIE)

build-custom:
	@make -s -f minimyth.mk mm-all DESTIMG=$(DESTIMG)
	@$(MAKECOOKIE)

install-custom:
	@make -s -f minimyth.mk mm-install DESTIMG=$(DESTIMG)
