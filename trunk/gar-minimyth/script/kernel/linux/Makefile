GARNAME = linux
GARVERSION = $(KERNEL_VERSION)
CATEGORIES = kernel
MASTER_SITES  = http://www.kernel.org/pub/linux/kernel/v$(KERNEL_MAJOR_VERSION).$(KERNEL_MINOR_VERSION)/
MASTER_SITES += http://www.kernel.org/pub/linux/kernel/v$(KERNEL_MAJOR_VERSION).$(KERNEL_MINOR_VERSION)/testing/
CONFIGFILE = $(DISTNAME)-$(GARCH_FAMILY)-$(GARCH).config
DISTFILES = $(DISTNAME).tar.bz2 $(CONFIGFILE)
PATCHFILES = $(DISTNAME)-defaults.patch $(DISTNAME)-via-rhine-pxeboot.patch $(DISTNAME)-cifs-1.39a.patch $(DISTNAME)-asus_acpi_hack.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c
BUILDDEPS = kernel/module-init-tools

CONFIGURE_SCRIPTS = custom
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = custom

CONFIGURE_ARGS = $(KERNEL_MAKE_ARGS)
BUILD_ARGS     = $(KERNEL_MAKE_ARGS) bzImage modules
INSTALL_ARGS   = $(KERNEL_MAKE_ARGS)

CONFIGURE_ENV = $(KERNEL_MAKE_ENV)
BUILD_ENV     = $(KERNEL_MAKE_ENV)
INSTALL_ENV   = $(KERNEL_MAKE_ENV) INSTALL_PATH="$(DESTDIR)$(KERNEL_DIR)" INSTALL_MOD_PATH="$(DESTDIR)$(rootdir)"

i386_KERNEL = arch/i386/boot/bzImage

include ../../gar.mk

configure-custom:
	@$(CONFIGURE_ENV) $(MAKE) $(CONFIGURE_ARGS) -C $(WORKSRC) mrproper
	@cp $(DOWNLOADDIR)/$(CONFIGFILE) $(WORKSRC)/.config
	@$(CONFIGURE_ENV) $(MAKE) $(CONFIGURE_ARGS) -C $(WORKSRC) oldconfig
	@$(CONFIGURE_ENV) $(MAKE) $(CONFIGURE_ARGS) -C $(WORKSRC) clean
	@$(MAKECOOKIE)

pre-install:
	@rm -rf "$(DESTDIR)$(KERNEL_DIR)"
	@rm -rf "$(DESTDIR)$(KERNEL_MODULESDIR)"
	@mkdir -p "$(DESTDIR)$(KERNEL_DIR)"
	@$(MAKECOOKIE)

install-custom:
	@mkdir -p "$(DESTDIR)$(KERNEL_DIR)"
	@cp $(WORKSRC)/arch/$(GARCH_FAMILY)/boot/bzImage $(DESTDIR)$(KERNEL_DIR)/vmlinuz
	@cp $(WORKSRC)/System.map                        $(DESTDIR)$(KERNEL_DIR)/System.map
	@$(INSTALL_ENV) $(MAKE) $(INSTALL_ARGS) -C $(WORKSRC) modules_install
	@$(MAKECOOKIE)

clean-all:
	@$(MAKE) clean -C ../alsa-driver
	@$(MAKE) clean -C ../drm
	@$(MAKE) clean -C ../linux
	@$(MAKE) clean -C ../nvidia
	@$(MAKE) clean -C ../unionfs
	@$(MAKE) clean -C ../vt1211
	@$(MAKE) clean -C ../../lirc
	@rm -rf $(DESTDIR)$(KERNEL_DIR)
	@rm -rf $(DESTDIR)$(KERNEL_MODULESPREFIX)
