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
	net/curl \
	disk/eject \
	utils/ethtool \
	devel/fakeroot \
	disk/hdparm \
	net/ifplugd \
	net/iputils \
	system/lcdproc \
	system/kbdd \
	kernel/kernel \
	system/lirc \
	utils/lm_sensors \
	utils/lsdvd \
	utils/microcode_ctl \
	utils/module-init-tools \
	net/mount.cifs \
	$(if $(wildcard ../../myth-$(mm_MYTH_VERSION)/myththemes),myth-$(mm_MYTH_VERSION)/myththemes) \
	$(if $(wildcard ../../myth-$(mm_MYTH_VERSION)/myththemes-blootube-osd),myth-$(mm_MYTH_VERSION)/myththemes-blootube-osd) \
	$(if $(wildcard ../../myth-$(mm_MYTH_VERSION)/myththemes-blootubelite-wide),myth-$(mm_MYTH_VERSION)/myththemes-blootubelite-wide) \
	$(if $(wildcard ../../myth-$(mm_MYTH_VERSION)/myththemes-addons),myth-$(mm_MYTH_VERSION)/myththemes-addons) \
	$(if $(wildcard ../../myth-$(mm_MYTH_VERSION)/mythtv),myth-$(mm_MYTH_VERSION)/mythtv) \
	lib/ncursesw \
	net/netpipes \
	net/nfs-utils \
	net/ntp \
	net/openssh \
	utils/pciutils \
	utils/pmount \
	net/portmap \
	system/powernowd \
	utils/powertop \
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
		$(if $(filter 2.6.23,$(mm_KERNEL_VERSION)),X11/IEGD)) \
	$(if $(filter nvidia,$(mm_CHIPSETS)), \
		nvidia/nvidia-$(mm_NVIDIA_VERSION)) \
	$(if $(filter mythaudio,$(mm_SOFTWARE)), \
		$(if $(wildcard ../../myth-$(mm_MYTH_VERSION)/mythaudio),myth-$(mm_MYTH_VERSION)/mythaudio)) \
	$(if $(filter mythbrowser,$(mm_SOFTWARE)), \
		$(if $(wildcard ../../myth-$(mm_MYTH_VERSION)/mythbrowser),myth-$(mm_MYTH_VERSION)/mythbrowser)) \
	$(if $(filter mythdvd,$(mm_SOFTWARE)), \
		$(if $(wildcard ../../myth-$(mm_MYTH_VERSION)/mythdvd),myth-$(mm_MYTH_VERSION)/mythdvd)) \
	$(if $(filter mythgallery,$(mm_SOFTWARE)), \
		$(if $(wildcard ../../myth-$(mm_MYTH_VERSION)/mythgallery),myth-$(mm_MYTH_VERSION)/mythgallery)) \
	$(if $(filter mythgame,$(mm_SOFTWARE)), \
		$(if $(wildcard ../../myth-$(mm_MYTH_VERSION)/mythgame),myth-$(mm_MYTH_VERSION)/mythgame) \
		emulators/fceu \
		emulators/jzintv \
		emulators/mednafen \
		emulators/stella \
		$(if $(filter mame,$(mm_SOFTWARE)),emulators/sdlmame) \
		emulators/VisualBoyAdvance \
		$(if $(filter i386,$(mm_GARCH_FAMILY)),emulators/zsnes)) \
	$(if $(filter mythmusic,$(mm_SOFTWARE)), \
		$(if $(wildcard ../../myth-$(mm_MYTH_VERSION)/mythmusic),myth-$(mm_MYTH_VERSION)/mythmusic)) \
	$(if $(filter mythnews,$(mm_SOFTWARE)), \
		$(if $(wildcard ../../myth-$(mm_MYTH_VERSION)/mythnews),myth-$(mm_MYTH_VERSION)/mythnews)) \
	$(if $(filter mythphone,$(mm_SOFTWARE)), \
		$(if $(wildcard ../../myth-$(mm_MYTH_VERSION)/mythphone),myth-$(mm_MYTH_VERSION)/mythphone)) \
	$(if $(filter mythstream,$(mm_SOFTWARE)), \
		$(if $(wildcard ../../myth-$(mm_MYTH_VERSION)/mythstream),myth-$(mm_MYTH_VERSION)/mythstream) \
		$(if $(filter perl,$(mm_SOFTWARE)), \
			perl/perl \
			perl/perl-HTML-Parser \
			perl/perl-libwww-perl \
			perl/perl-XML-DOM \
			perl/perl-XML-XQL)) \
	$(if $(filter mythvideo,$(mm_SOFTWARE)), \
		$(if $(wildcard ../../myth-$(mm_MYTH_VERSION)/mythvideo),myth-$(mm_MYTH_VERSION)/mythvideo) \
		$(if $(filter perl,$(mm_SOFTWARE)), \
			perl/perl \
			perl/perl-HTML-Parser \
			perl/perl-libwww-perl \
			perl/perl-URI)) \
	$(if $(filter mythweather,$(mm_SOFTWARE)), \
		$(if $(wildcard ../../myth-$(mm_MYTH_VERSION)/mythweather),myth-$(mm_MYTH_VERSION)/mythweather) \
		$(if $(filter perl,$(mm_SOFTWARE)), \
			perl/perl \
			perl/perl-Date-Manip \
			perl/perl-Image-Size \
			perl/perl-libwww-perl \
			perl/perl-SOAP-Lite \
			perl/perl-XML-Parser \
			perl/perl-XML-SAX \
			perl/perl-XML-Simple)) \
	$(if $(filter mythzoneminder,$(mm_SOFTWARE)), \
		$(if $(wildcard ../../myth-$(mm_MYTH_VERSION)/mythzoneminder),myth-$(mm_MYTH_VERSION)/mythzoneminder)) \
	$(if $(filter mplayer,$(mm_SOFTWARE)), \
		mediaplayers/mplayer) \
	$(if $(filter xine,$(mm_SOFTWARE)), \
		mediaplayers/xine-ui) \
	$(if $(filter transcode,$(mm_SOFTWARE)), \
		utils/transcode) \
	$(if $(filter wiimote,$(mm_SOFTWARE)), \
		utils/cwiid \
		utils/bluez-utils) \
	$(if $(filter debug,$(mm_SOFTWARE)), \
		devel/gdb \
		devel/strace) \
	$(filter-out %/Makefile extras/extras-% extras/extras.%,$(subst ../../,,$(wildcard ../../extras/*))) \
	$(mm_USER_PACKAGES)

BUILDDEPS = \
	utils/coreutils \
	devel/fakeroot \
	utils/file \
	utils/findutils \
	utils/squashfs \
	utils/tar \
	utils/util-linux-ng \
	xorg/xorg \
	perl/perlsharp

BUILD_SCRIPTS   = custom
INSTALL_SCRIPTS = custom

include ../../gar.mk

pre-fetch:
	@$(MAKE) -s -f minimyth.mk mm-check DESTIMG=$(DESTIMG)
	@$(MAKECOOKIE)

build-custom:
	@$(MAKE) -s -f minimyth.mk mm-build DESTIMG=$(DESTIMG)
	@$(MAKECOOKIE)

install-custom:
	@$(MAKE) -s -f minimyth.mk mm-install DESTIMG=$(DESTIMG)
