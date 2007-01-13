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
 	utils/alsa-utils \
	system/bootsplash \
	utils/busybox \
	devel/gdb \
	system/lcdproc \
	kernel/linux kernel/alsa-driver kernel/drm kernel/unionfs \
	lirc/lirc \
	utils/lm_sensors \
	kernel/module-init-tools \
	myth/mplayer \
	myth/mythdvd \
	myth/mythgallery \
	myth/mythmusic \
	myth/mythvideo \
	myth/mythtv \
	myth/mythweather \
	net/ntp \
	net/portmap \
	qt/qt \
	X11/ratpoison \
	X11/rxvt \
	net/samba \
	utils/strace \
	net/utelnetd \
	system/udev \
	X11/unichrome_dri \
	utils/util-linux \
	net/webfs \
	X11/X11 \
	X11/x11vnc \
	myth/xine-ui \
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
