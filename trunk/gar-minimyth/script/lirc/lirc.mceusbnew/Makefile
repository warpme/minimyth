GARNAME = lirc.mceusbnew
GARVERSION = $(LIRC_VERSION)
CATEGORIES = lirc
SOURCEPKG = lirc/lirc
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c kernel/linux lib/alsa-lib lib/libusb

WORKSRC = $(WORKDIR)/lirc-$(LIRC_VERSION)

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--program-suffix=".mceusbnew" \
	--enable-sandboxed \
	--with-gnu-ld \
	--without-x \
	--with-kerneldir="$(DESTDIR)$(KERNEL_SOURCEDIR)" \
	--with-moduledir="$(KERNEL_MODULESDIR)/misc/lirc" \
	--with-driver=mceusbnew
BUILD_ARGS     = $(KERNEL_MAKE_ARGS)
INSTALL_ARGS   = $(KERNEL_MAKE_ARGS)

CONFIGURE_ENV = $(KERNEL_MAKE_ENV) LIBUSB_CONFIG=$(DESTDIR)$(bindir)/libusb-config
BUILD_ENV     = $(KERNEL_MAKE_ENV)
INSTALL_ENV   = $(KERNEL_MAKE_ENV)

GAR_EXTRA_CONF += kernel/linux/package-api.mk lirc/lirc/package-api.mk
include ../../gar.mk

post-install:
	@rm -f $(DESTDIR)$(libdir)/liblirc_client.la
	@depmod -e -b $(DESTDIR) -v $(KERNEL_FULL_VERSION)
	@$(MAKECOOKIE)
