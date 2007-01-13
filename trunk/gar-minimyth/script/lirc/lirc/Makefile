GARNAME = lirc
GARVERSION = $(LIRC_VERSION)
CATEGORIES = lirc
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-libusb.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS  = lang/c kernel/linux lib/alsa-lib lib/libusb X11/X11 lirc/libirman
DEPENDS += lirc/lirc.any lirc/lirc.atiusb lirc/lirc.imon lirc/lirc.mceusb lirc/lirc.serial lirc/lirc.streamzap

WORKSRC = $(WORKDIR)/lirc-$(LIRC_VERSION)

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-sandboxed \
	--x-includes="$(DESTDIR)$(x11includedir)" \
	--x-libraries="$(DESTDIR)$(x11libdir)" \
	--with-gnu-ld \
	--with-kerneldir="$(DESTDIR)$(KERNEL_SOURCEDIR)" \
	--with-moduledir="$(KERNEL_MODULESDIR)/misc/lirc" \
	--with-driver=none
BUILD_ARGS     = $(KERNEL_MAKE_ARGS)
INSTALL_ARGS   = $(KERNEL_MAKE_ARGS)

CONFIGURE_ENV = $(KERNEL_MAKE_ENV) LIBUSB_CONFIG=$(DESTDIR)$(bindir)/libusb-config
BUILD_ENV     = $(KERNEL_MAKE_ENV)
INSTALL_ENV   = $(KERNEL_MAKE_ENV)

GAR_EXTRA_CONF += kernel/linux/package-api.mk lirc/lirc/package-api.mk
include ../../gar.mk

post-patch:
	@# Libtool wants to hardcode library paths. This stops that unwanted behavior.
	@sed -i 's%^hardcode_libdir_flag_spec=.*%hardcode_libdir_flag_spec=%' $(WORKSRC)/configure
	@# Libtool wants to modify the library run path. This stops that unwanted behavior.
	@sed -i 's%^runpath_var=.*%runpath_var=%' $(WORKSRC)/configure
	@# Libtool wants search system directories rather than DESTIMG directories. This stops that unwanted behavior.
	@sed -i 's%^sys_lib_dlsearch_path_spec=.*%sys_lib_dlsearch_path_spec=%' $(WORKSRC)/configure
	@sed -i 's%^sys_lib_search_path_spec=.*%sys_lib_search_path_spec=%' $(WORKSRC)/configure
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/liblirc_client.la
	@depmod -b $(DESTDIR) -v $(KERNEL_FULL_VERSION)
	@$(MAKECOOKIE)
