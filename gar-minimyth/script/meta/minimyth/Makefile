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
	X11/blackbox \
	utils/busybox \
	system/devfsd \
	devel/gdb \
	kernel/linux kernel/drm \
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
	net/samba \
	net/utelnetd \
	utils/util-linux \
	net/webfs \
	X11/X11 \
	X11/x11vnc
BUILDDEPS = \
	utils/util-linux

BUILD_SCRIPTS   = custom
INSTALL_SCRIPTS = custom

include ../../gar.mk

build-custom:
	@make -s -f minimyth.mk mm-all DESTIMG=$(DESTIMG)
	@$(MAKECOOKIE)

install-custom:
	@su -c "cp -a $(mm_DESTDIR) $(mm_DESTDIR).tmp ; \
		chown -R root:root $(mm_DESTDIR).tmp ; \
		mknod -m 666 $(mm_DESTDIR).tmp/$(rootdir)/dev/null c 1 3 ; \
		mknod -m 600 $(mm_DESTDIR).tmp/$(rootdir)/dev/console c 5 1 ; \
		mkfs.cramfs $(mm_DESTDIR).tmp $(mm_BASEDIR)/$(mm_CRAMFSNAME) ; \
		rm -rf $(mm_DESTDIR).tmp ; \
		rm -f $(mm_TFTPDIR)/$(mm_KERNELNAME) ; cp $(mm_BASEDIR)/$(mm_KERNELNAME) $(mm_TFTPDIR)/$(mm_KERNELNAME) ; \
		rm -f $(mm_TFTPDIR)/$(mm_CRAMFSNAME) ; cp $(mm_BASEDIR)/$(mm_CRAMFSNAME) $(mm_TFTPDIR)/$(mm_CRAMFSNAME)"

install-cramfs: install

install-nfs: build
	@su -c "cp -a $(mm_DESTDIR) $(mm_DESTDIR).tmp ; \
		chown -R root:root $(mm_DESTDIR).tmp ; \
		mknod -m 666 $(mm_DESTDIR).tmp/$(rootdir)/dev/null c 1 3 ; \
		mknod -m 600 $(mm_DESTDIR).tmp/$(rootdir)/dev/console c 5 1 ; \
		rm -rf $(mm_NFSDIR)/$(mm_NFSNAME) ; cp -a $(mm_DESTDIR).tmp $(mm_NFSDIR)/$(mm_NFSNAME) ; \
		rm -rf $(mm_DESTDIR).tmp ; \
		rm -f $(mm_TFTPDIR)/$(mm_KERNELNAME) ; cp $(mm_BASEDIR)/$(mm_KERNELNAME) $(mm_TFTPDIR)/$(mm_KERNELNAME)"
