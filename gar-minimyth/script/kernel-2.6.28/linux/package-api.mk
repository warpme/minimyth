LINUX_MAJOR_VERSION = 2
LINUX_MINOR_VERSION = 6
LINUX_TEENY_VERSION = 28
LINUX_EXTRA_VERSION = .7

LINUX_VERSION = $(LINUX_MAJOR_VERSION).$(LINUX_MINOR_VERSION).$(LINUX_TEENY_VERSION)$(LINUX_EXTRA_VERSION)
LINUX_FULL_VERSION = $(LINUX_VERSION)

LINUX_MAKEFILE = $(DESTDIR)$(rootdir)/lib/modules/$(LINUX_VERSION)*/source/Makefile

LINUX_DIR           = $(rootdir)/boot
LINUX_DIR           = $(rootdir)/boot
LINUX_MODULESPREFIX = $(rootdir)/lib/modules
LINUX_MODULESDIR    = $(LINUX_MODULESPREFIX)/$(LINUX_FULL_VERSION)
LINUX_SOURCEDIR     = $(LINUX_MODULESDIR)/source
LINUX_BUILDDIR      = $(LINUX_MODULESDIR)/build

LINUX_MAKE_ARGS = \
	ARCH="$(GARCH_FAMILY)" \
	HOSTCC="$(build_CC)" \
	HOSTCXX="$(build_CXX)" \
	HOSTCFLAGS="$(build_CFLAGS)" \
	HOSTCXXFLAGS="$(build_CXXFLAGS)" \
	CROSS_COMPILE="$(compiler_prefix)"

LINUX_MAKE_ENV = \
	KBUILD_VERBOSE="1"
