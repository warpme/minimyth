GARNAME = lirc.serial
GARVERSION = $(LIRC_VERSION)
CATEGORIES = lirc
SOURCEPKG = lirc/lirc
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c kernel/linux lib/alsa-lib lib/libusb X11/X11

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
	--program-suffix=".serial" \
	--enable-sandboxed \
	--x-includes="$(DESTDIR)$(x11includedir)" \
	--x-libraries="$(DESTDIR)$(x11libdir)" \
	--with-gnu-ld \
	--with-kerneldir="$(DESTDIR)$(KERNEL_SOURCEDIR)" \
	--with-moduledir="$(KERNEL_MODULESDIR)/misc/lirc" \
	--with-driver=serial
BUILD_ARGS     = $(DEFAULT_ARGS)
INSTALL_ARGS   = $(DEFAULT_ARGS)

CONFIGURE_ENV  = KBUILD_VERBOSE=1 LIBUSB_CONFIG=$(DESTDIR)$(bindir)/libusb-config
BUILD_ENV      = KBUILD_VERBOSE=1
INSTALL_ENV    = KBUILD_VERBOSE=1

GAR_EXTRA_CONF += kernel/linux/package-api.mk lirc/lirc/package-api.mk
include ../../gar.mk

post-install:
	@rm -f $(DESTDIR)$(libdir)/liblirc_client.la
	@depmod -e -b $(DESTDIR) -v $(KERNEL_FULL_VERSION)
	@$(MAKECOOKIE)
