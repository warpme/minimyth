LIRC_VERSION = 0.8.0pre1

LIRC_DEPENDS = lang/c kernel/linux lib/alsa-lib lib/libusb lirc/libirman

LIRC_WORKSRC = $(WORKDIR)/lirc-$(LIRC_VERSION)

LIRC_CONFIGURE_SCRIPTS = $(WORKSRC)/configure
LIRC_BUILD_SCRIPTS     = $(WORKSRC)/Makefile
LIRC_INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

LIRC_CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-sandboxed \
	--with-gnu-ld \
	--without-x \
	--with-kerneldir="$(DESTDIR)$(KERNEL_SOURCEDIR)" \
	--with-moduledir="$(KERNEL_MODULESDIR)/misc/lirc"
LIRC_BUILD_ARGS     = $(KERNEL_MAKE_ARGS)
LIRC_INSTALL_ARGS   = $(KERNEL_MAKE_ARGS)

LIRC_CONFIGURE_ENV = $(KERNEL_MAKE_ENV) LIBUSB_CONFIG=$(DESTDIR)$(bindir)/libusb-config
LIRC_BUILD_ENV     = $(KERNEL_MAKE_ENV)
LIRC_INSTALL_ENV   = $(KERNEL_MAKE_ENV)

include ../../kernel/linux/package-api.mk
