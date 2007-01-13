GARNAME = minimyth
GARVERSION = none
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
	system/bootsplash \
	utils/busybox \
	devel/gdb \
	system/lcdproc \
	X11/libXvMCW \
	kernel/linux kernel/alsa-driver kernel/drm kernel/unionfs kernel/vt1211 \
	lirc/lirc \
	utils/lm_sensors \
	utils/lsdvd \
	kernel/module-init-tools \
	X11/Mesa \
	mediaplayers/mplayer \
	myth/myth \
	net/ntp \
	net/portmap \
	qt/qt \
	X11/rxvt \
	net/samba \
	utils/strace \
	system/udev \
	X11/unichrome \
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

build-custom:
	@make -s -f minimyth.mk mm-all DESTIMG=$(DESTIMG)
	@$(MAKECOOKIE)

install-custom:
	@make -s -f minimyth.mk mm-install DESTIMG=$(DESTIMG)
