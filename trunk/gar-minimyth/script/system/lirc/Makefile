GARNAME = lirc
#GARVERSION = 0.8.4a
GARVERSION = 20090120Z
CATEGORIES = system
#MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
#MASTER_SITES = http://www.lirc.org/software/snapshots/
MASTER_SITES = cvs://anonymous@$(GARNAME).cvs.sourceforge.net:/cvsroot/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
#PATCHFILES = $(DISTNAME)-usb_sysfs.patch $(DISTNAME)-lirc_i2c_device.patch $(DISTNAME)-no_python.patch $(DISTNAME)-imon_module_param.patch $(DISTNAME)-imon_lcd_dynamic.patch $(DISTNAME)-remove_smp_unsafe_drivers.patch
PATCHFILES = $(DISTNAME)-no_python.patch $(DISTNAME)-remove_request_module.patch $(DISTNAME)-remove_smp_unsafe_drivers.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c kernel/kernel lib/alsa-lib lib/libftdi lib/libirman lib/libusb xorg/xorg

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes="$(DESTDIR)$(includedir)" \
	--x-libraries="$(DESTDIR)$(libdir)" \
	--enable-shared \
	--disable-static \
	--enable-sandboxed \
	--with-gnu-ld \
	--with-x \
	--with-kerneldir="$(DESTDIR)$(LINUX_SOURCEDIR)" \
	--with-moduledir="$(LINUX_MODULESDIR)/misc/lirc" \
	--with-driver=all \
	--with-transmitter
BUILD_ARGS     = $(LINUX_MAKE_ARGS)
INSTALL_ARGS   = $(LINUX_MAKE_ARGS)

CONFIGURE_ENV = $(LINUX_MAKE_ENV) LIBUSB_CONFIG=$(DESTDIR)$(bindir)/libusb-config
BUILD_ENV     = $(LINUX_MAKE_ENV)
INSTALL_ENV   = $(LINUX_MAKE_ENV)

GAR_EXTRA_CONF += kernel-$(mm_KERNEL_VERSION)/linux/package-api.mk
include ../../gar.mk

PARALLELMFLAGS := -j1

cvs//%/$(DISTNAME).tar.bz2:
	@$(call FETCH_CVS, $*, $(GARNAME), $(GARVERSION), $(DISTNAME))
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/liblirc_client.la
	@depmod -b $(DESTDIR) -v $(LINUX_FULL_VERSION)
	@$(MAKECOOKIE)

clean-all:
	@$(MAKE) clean
	@rm -rf $(DESTDIR)$(LINUX_MODULESDIR)/misc/lirc
	@rm -rf $(DESTDIR)$(bindir)/lirc*
	@rm -rf $(DESTDIR)$(sbindir)/lirc*
	@rm -rf $(DESTDIR)$(includedir)/lirc
	@rm -rf $(DESTDIR)$(libdir)/liblirc_client.*
	@rm -rf $(DESTDIR)$(mandir)/man1/lirc*
	@rm -rf $(DESTDIR)$(mandir)/man8/lirc*
