GARNAME = udev
GARVERSION = 121
CATEGORIES = system
MASTER_SITES = ftp://ftp.kernel.org/pub/linux/utils/kernel/hotplug/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

BUILD_SCRIPTS   = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = $(WORKSRC)/Makefile

DEFAULT_ARGS = \
	V=true \
	INSTALL="install" \
	HOSTCC="$(build_CC)" \
	CROSS_COMPILE="$(compiler_prefix)" \
	CC="$(CC)" \
	LD="$(CC)" \
	AR="$(AR)" \
	STRIP="$(STRIP)" \
	RANLIB="$(RANLIB)" \
	DESTDIR="$(DESTDIR)" \
	OPTFLAGS="$(CFLAGS)" \
	prefix="$(prefix)" \
	exec_prefix="$(exec_prefix)" \
	etcdir="$(sysconfdir)" \
	sbindir="$(esbindir)" \
	usrbindir="$(bindir)" \
	usrsbindir="$(sbindir)" \
	libudevdir="${elibdir}/udev" \
	mandir="$(mandir)" \
	configdir="$(sysconfdir)/udev" \
	udevdir="$(rootdir)/dev" \
	includedir="$(includedir)" \
	libdir="$(elibdir)" \
	usrlibdir="$(libdir)"

BUILD_ARGS   = $(DEFAULT_ARGS) EXTRAS="extras/cdrom_id/ extras/volume_id/"
INSTALL_ARGS = $(DEFAULT_ARGS) EXTRAS="extras/cdrom_id/ extras/volume_id/"

include ../../gar.mk

pre-install:
	@rm -rf $(DESTDIR)$(elibdif)/udev
	@rm -rf $(DESTDIR)$(sysconfdir)/udev
	@$(MAKECOOKIE)

post-install:
	@ln -f -s $(patsubst /%,%,$(call DIRSTODOTS,$(esbindir)))$(esbindir)/udevadm $(DESTDIR)$(esbindir)/udevtrigger
	@ln -f -s $(patsubst /%,%,$(call DIRSTODOTS,$(esbindir)))$(esbindir)/udevadm $(DESTDIR)$(esbindir)/udevsettle
	@ln -f -s $(patsubst /%,%,$(call DIRSTODOTS,$(esbindir)))$(esbindir)/udevadm $(DESTDIR)$(esbindir)/udevcontrol
	@ln -f -s $(patsubst /%,%,$(call DIRSTODOTS,$(sbindir)))$(esbindir)/udevadm $(DESTDIR)$(sbindir)/udevmonitor
	@ln -f -s $(patsubst /%,%,$(call DIRSTODOTS,$(bindir)))$(esbindir)/udevadm $(DESTDIR)$(bindir)/udevinfo
	@ln -f -s $(patsubst /%,%,$(call DIRSTODOTS,$(bindir)))$(esbindir)/udevadm $(DESTDIR)$(bindir)/udevtest
	@rm -f $(DESTDIR)$(libdir)/libvolume_id.so
	ln -s .$(call DIRSTODOTS,$(libdir))$(elibdir)/libvolume_id.so.0 $(DESTDIR)$(libdir)/libvolume_id.so
	@$(MAKECOOKIE)
