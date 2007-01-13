GARNAME = linux
GARVERSION = $(KERNEL_VERSION)
CATEGORIES = kernel
MASTER_SITES = http://www.kernel.org/pub/linux/kernel/v$(KERNEL_MAJOR_VERSION).$(KERNEL_MINOR_VERSION)/
CONFIGFILE = $(DISTNAME)-$(GARCH).config
DISTFILES = $(DISTNAME).tar.bz2 $(CONFIGFILE)
#PATCHFILES = $(DISTNAME)-via-rhine-pxeboot.patch $(DISTNAME)-bootsplash.patch
PATCHFILES = $(DISTNAME)-bootsplash.patch
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
	@cp $(WORKSRC)/$($(KERNEL_ARCH)_KERNEL) $(DESTDIR)$(KERNEL_DIR)/vmlinuz
	@cp $(WORKSRC)/System.map               $(DESTDIR)$(KERNEL_DIR)/System.map
	@$(INSTALL_ENV) $(MAKE) $(INSTALL_ARGS) -C $(WORKSRC) modules_install
	@$(MAKECOOKIE)
