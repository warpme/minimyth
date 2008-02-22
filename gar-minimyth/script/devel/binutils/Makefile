GARNAME = binutils
GARVERSION = $(BINUTILS_VERSION)
CATEGORIES = devel
MASTER_SITES  = ftp://ftp.gnu.org/gnu/$(GARNAME)/
MASTER_SITES += ftp://ftp.kernel.org/pub/linux/devel/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-perl.patch.gar
LICENSE = GPL3/GPL2/LGPL2

DESCRIPTION =
define BLURB
endef

CROSSIMG ?= $(DESTIMG)
GARTARGET = $($(CROSSIMG)_GARHOST)

DEPENDS = lang/c
ifeq ("$(DESTIMG)+$(CROSSIMG)","build+build")
# If the build system's binutils version is not older than our binutils version,
# then build a minimal gcc before binutils,
# since the build system's gcc may depend on features in the build system's newer binutils.
BUILDDEPS  = $(if $(filter $(BINUTILS_BUILD_UP_TO_DATE),yes),devel/gcc-minimal-shared)
endif

WORKDIR   = $(WORKROOTDIR)/$(DESTIMG)_$(CROSSIMG).d
COOKIEDIR = $(COOKIEROOTDIR)/$(DESTIMG)_$(CROSSIMG).d

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS  = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) --target=$(GARTARGET) \
	--enable-shared \
	--with-sysroot=$($(CROSSIMG)_DESTDIR)
# I do not know what '=' does at the beginning of the path name. However, the correct libraries are not found without it.
# For the native environment, glibc is not installed, so the native environment needs to pick up glibc from the system.
# Libraries are located in /lib and /usr/lib. On some systems, x86_64 libraries are located in /lib64 and /usr/lib64.
ifeq ("$(DESTIMG)+$(CROSSIMG)","build+build")
CONFIGURE_ARGS += \
	--with-lib-path="=$($(CROSSIMG)_elibdir):=$($(CROSSIMG)_libdir):/lib:/usr/lib:/lib64:/usr/lib64"
else
CONFIGURE_ARGS += \
	--with-lib-path="=$($(CROSSIMG)_elibdir):=$($(CROSSIMG)_libdir)"
endif

GAR_EXTRA_CONF += devel/gcc/package-api.mk
include ../../gar.mk

CPPFLAGS :=
CFLAGS   :=
CXXFLAGS :=
LDFLAGS  :=

post-install:
	@rm -f $(DESTDIR)$(libdir)/libbfd.la
	@rm -f $(DESTDIR)$(libdir)/libopcodes.la
	@$(if $(filter $(GARHOST), $(GARTARGET)),, rm -f $(DESTDIR)$(prefix)/$(GARHOST)/$(GARTARGET)/lib/libbfd.la)
	@$(if $(filter $(GARHOST), $(GARTARGET)),, rm -f $(DESTDIR)$(prefix)/$(GARHOST)/$(GARTARGET)/lib/libopcodes.la)
	@rm -f $(DESTDIR)$(libdir)/libopcodes.la
	@$(MAKECOOKIE)
