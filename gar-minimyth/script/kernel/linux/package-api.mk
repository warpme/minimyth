KERNEL_MAJOR_VERSION = 2
KERNEL_MINOR_VERSION = 6
KERNEL_SUBMINOR_VERSION = 10

KERNEL_VERSION = $(KERNEL_MAJOR_VERSION).$(KERNEL_MINOR_VERSION).$(KERNEL_SUBMINOR_VERSION)
KERNEL_FULL_VERSION = $(KERNEL_VERSION)$(KERNEL_EXTRA_VERSION)

KERNEL_MAKEFILE = $(DESTDIR)$(rootdir)/lib/modules/$(KERNEL_VERSION)*/source/Makefile
KERNEL_EXTRA_VERSION = $(shell grep ^EXTRAVERSION $(KERNEL_MAKEFILE) | cut -d' ' -f3)

KERNEL_ARCH = $(strip $(shell grep ^$(shell echo $(GARTARGET) | cut -d- -f1): $(GARDIR)/kernel/linux/kernel-arch-map | cut -d: -f2))

KERNEL_DIR        = $(rootdir)/boot
KERNEL_MODULESDIR = $(rootdir)/lib/modules/$(KERNEL_FULL_VERSION)
KERNEL_SOURCEDIR  = $(KERNEL_MODULESDIR)/source
KERNEL_BUILDDIR   = $(KERNEL_MODULESDIR)/build

KERNEL_MAKE_ARGS = \
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
KERNEL_MAKE_ENV = \
	KBUILD_VERBOSE="1"
