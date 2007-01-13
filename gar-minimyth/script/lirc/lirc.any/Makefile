GARNAME = lirc.any
GARVERSION = $(LIRC_VERSION)
CATEGORIES = lirc
SOURCEPKG = lirc/lirc
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c kernel/linux lib/alsa-lib lib/libusb X11/X11 lirc/libirman

WORKSRC = $(WORKDIR)/lirc-$(LIRC_VERSION)

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

DEFAULT_ARGS   = \
	HOSTCC="$(build_CC)" \
	HOSTCXX="$(build_CXX)" \
	HOSTCFLAGS="$(build_CFLAGS)" \
	HOSTCXXFLAGS="$(build_CXXFLAGS)" \
	AS="$(AS)" \
	LD="$(LD)" \
	CC="$(CC)" \
	CPP="$(CPP)" \
	AR="$(AR)" \
	NM="$(NM)" \
	STRIP="$(STRIP)" \
	OBJCOPY="$(OBJCOPY)" \
	OBJDUMP="$(OBJDUMP)"
CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-sandboxed \
	--x-includes="$(DESTDIR)$(x11includedir)" \
	--x-libraries="$(DESTDIR)$(x11libdir)" \
	--with-gnu-ld \
	--with-kerneldir="$(DESTDIR)$(KERNEL_SOURCEDIR)" \
	--with-moduledir="$(KERNEL_MODULESDIR)/misc/lirc" \
	--with-driver=any
BUILD_ARGS     = $(DEFAULT_ARGS)
INSTALL_ARGS   = $(DEFAULT_ARGS)

CONFIGURE_ENV  = KBUILD_VERBOSE=1 LIBUSB_CONFIG=$(DESTDIR)$(bindir)/libusb-config
BUILD_ENV      = KBUILD_VERBOSE=1
INSTALL_ENV    = KBUILD_VERBOSE=1

GAR_EXTRA_CONF += kernel/linux/package-api.mk lirc/lirc/package-api.mk
include ../../gar.mk

post-install:
	@rm -f $(DESTDIR)$(libdir)/liblirc_client.la
	@mv $(DESTDIR)$(sbindir)/lircd $(DESTDIR)$(sbindir)/lircd.any
	@depmod -b $(DESTDIR) -v $(KERNEL_FULL_VERSION)
	@$(MAKECOOKIE)
