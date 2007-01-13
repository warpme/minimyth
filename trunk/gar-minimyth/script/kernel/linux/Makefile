GARNAME = linux
GARVERSION = $(KERNEL_VERSION).1
CATEGORIES = kernel
MASTER_SITES = http://www.kernel.org/pub/linux/kernel/v$(KERNEL_MAJOR_VERSION).$(KERNEL_MINOR_VERSION)/
CONFIGFILE = $(GARNAME)-$(GARVERSION)-via_epia_m-$(GARCH).config
DISTFILES = $(GARNAME)-$(GARVERSION).tar.bz2 $(CONFIGFILE)
PATCHFILES = $(GARNAME)-$(GARVERSION)-vt1211.patch $(GARNAME)-$(GARVERSION)-touchkitusb.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c
BUILDDEPS = kernel/module-init-tools

CONFIGURE_SCRIPTS = custom
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = custom

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
CONFIGURE_ARGS = $(DEFAULT_ARGS)
BUILD_ARGS     = $(DEFAULT_ARGS) bzImage modules
INSTALL_ARGS   = $(DEFAULT_ARGS)

CONFIGURE_ENV = KBUILD_VERBOSE=1
BUILD_ENV     = KBUILD_VERBOSE=1
INSTALL_ENV   = KBUILD_VERBOSE=1 INSTALL_PATH="$(DESTDIR)$(KERNEL_DIR)" INSTALL_MOD_PATH="$(DESTDIR)$(rootdir)"

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
