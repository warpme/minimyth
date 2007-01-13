#-*- mode: Fundamental; tab-width: 4; -*-
# ex:ts=4

# This file contains configuration variables that are global to
# the GAR system.  Users wishing to make a change on a
# per-package basis should edit the category/package/Makefile, or
# specify environment variables on the make command-line.

# Variables that define the default *actions* (rather than just
# default data) of the system will remain in bbc.gar.mk
# (bbc.port.mk)

# Setting this variable will cause the results of your builds to
# be cleaned out after being installed.  Uncomment only if you
# desire this behavior!

# export BUILD_CLEAN = true

ALL_DESTIMGS = main build

# These are the standard directory name variables from all GNU
# makefiles.  They're also used by autoconf, and can be adapted
# for a variety of build systems.
# 
# TODO: set $(SYSCONFDIR) and $(LOCALSTATEDIR) to never use
# /usr/etc or /usr/var

# Directory config for the "main" image
main_rootdir ?= /
# Warning: any changes to these paths will cause certain packages to break.
main_prefix = $(main_rootdir)/usr
main_exec_prefix = $(main_rootdir)/usr
main_x11prefix = $(main_rootdir)/usr/X11R6
main_x11bindir = $(main_x11prefix)/bin
main_x11includedir = $(main_x11prefix)/include
main_x11libdir = $(main_x11prefix)/lib
main_qtprefix = $(main_libdir)/qt
main_qtbindir = $(main_qtprefix)/bin
main_qtincludedir = $(main_qtprefix)/include
main_qtlibdir = $(main_qtprefix)/lib
main_ebindir = $(main_rootdir)/bin
main_bindir = $(main_rootdir)/usr/bin
main_esbindir = $(main_rootdir)/sbin
main_sbindir = $(main_rootdir)/usr/sbin
main_libexecdir = $(main_rootdir)/usr/libexec
main_datadir = $(main_rootdir)/usr/share
main_sysconfdir = $(main_rootdir)/etc
main_sharedstatedir = $(main_rootdir)/usr/share
main_localstatedir = $(main_rootdir)/var
main_elibdir = $(main_rootdir)/lib
main_libdir = $(main_rootdir)/usr/lib
main_infodir = $(main_rootdir)/usr/info
main_lispdir = $(main_rootdir)/usr/share/emacs/site-lisp
main_includedir = $(main_rootdir)/usr/include
main_oldincludedir = $(main_rootdir)/usr/include
main_mandir = $(main_rootdir)/usr/man
main_docdir = $(main_rootdir)/usr/share/doc
main_sourcedir = $(main_rootdir)/usr/src
main_licensedir = $(main_rootdir)/usr/licenses

# Directory config for the "build" image
build_rootdir ?= $(mm_HOME)/images/build
# Warning: any changes to these paths will cause certain packages to break.
build_prefix = $(build_rootdir)/usr
build_exec_prefix = $(build_rootdir)/usr
build_x11prefix = $(build_rootdir)/usr/X11R6
build_x11bindir = $(build_x11prefix)/bin
build_x11includedir = $(build_x11prefix)/include
build_x11libdir = $(build_x11prefix)/lib
build_qtprefix = $(build_libdir)/qt
build_qtbindir = $(build_qtprefix)/bin
build_qtincludedir = $(build_qtprefix)/include
build_qtlibdir = $(build_qtprefix)/lib
build_ebindir = $(build_rootdir)/bin
build_bindir = $(build_rootdir)/usr/bin
build_esbindir = $(build_rootdir)/sbin
build_sbindir = $(build_rootdir)/usr/sbin
build_libexecdir = $(build_rootdir)/usr/libexec
build_datadir = $(build_rootdir)/usr/share
build_sysconfdir = $(build_rootdir)/etc
build_sharedstatedir = $(build_rootdir)/usr/share
build_localstatedir = $(build_rootdir)/var
build_elibdir = $(build_rootdir)/lib
build_libdir = $(build_rootdir)/usr/lib
build_infodir = $(build_rootdir)/usr/info
build_lispdir = $(build_rootdir)/usr/share/emacs/site-lisp
build_includedir = $(build_rootdir)/usr/include
build_oldincludedir = $(build_rootdir)/usr/include
build_mandir = $(build_rootdir)/usr/man
build_docdir = $(build_rootdir)/usr/share/doc
build_sourcedir = $(build_rootdir)/usr/src
build_licensedir = $(build_rootdir)/usr/licenses

# the DESTDIR is used at INSTALL TIME ONLY to determine what the
# filesystem root should be.  Each different DESTIMG has its own
# DESTDIR.
main_DESTDIR ?= $(mm_HOME)/images/main
build_DESTDIR ?= /
build_chroot_DESTDIR ?= /tmp/chroot

# allow us to link to libraries we installed
main_CPPFLAGS += 
main_CFLAGS += -march=$(GARCH) -pipe -O3 -fomit-frame-pointer
main_LDFLAGS += 
#main_CXXFLAGS += -march=$(GARCH) -pipe -O3 -fomit-frame-pointer

# allow us to link to libraries we installed
build_CPPFLAGS += 
build_CFLAGS += -march=i586 -pipe -O3 -fomit-frame-pointer
#build_CXXFLAGS += -march=i586 -pipe -O3 -fomit-frame-pointer
build_LDFLAGS += 

# Default main_CC to gcc, $(DESTIMG)_CC to main_CC and set CC based on $(DESTIMG)
main_compiler_prefix ?= $(GARHOST)-
main_CC = $(main_compiler_prefix)gcc
main_CXX = $(main_compiler_prefix)g++
main_LD = $(main_compiler_prefix)ld
main_OBJDUMP = $(main_compiler_prefix)objdump
main_OBJCOPY = $(main_compiler_prefix)objcopy
main_STRIP = $(main_compiler_prefix)strip
main_RANLIB = $(main_compiler_prefix)ranlib
main_NM = $(main_compiler_prefix)nm
main_AS = $(main_compiler_prefix)as
main_AR = $(main_compiler_prefix)ar
main_CPP = $(main_compiler_prefix)cpp
build_compiler_prefix ?= 
build_CC = $(build_compiler_prefix)gcc
build_CXX = $(build_compiler_prefix)g++
build_LD = $(build_compiler_prefix)ld
build_OBJDUMP = $(build_compiler_prefix)objdump
build_OBJCOPY = $(build_compiler_prefix)objcopy
build_STRIP = $(build_compiler_prefix)strip
build_RANLIB = $(build_compiler_prefix)ranlib
build_NM = $(build_compiler_prefix)nm
build_AS = $(build_compiler_prefix)as
build_AR = $(build_compiler_prefix)ar
build_CPP = $(build_compiler_prefix)cpp

# GARCH and GARHOST for main.  Override these for cross-compilation
main_GARCH ?= $(mm_GARCH)
main_GARHOST ?= $(mm_GARHOST)

# GARCH and GARHOST for build.  Do not change these.
build_GARCH := $(shell arch)
build_GARHOST := $(GARBUILD)

# Don't build these packages as in the build image
build_NODEPEND += kernel/linux-libc-headers devel/glibc

# This is for foo-config chaos
PKG_CONFIG_PATH=$(DESTDIR)$(libdir)/pkgconfig/

# Put these variables in the environment during the
# configure build and install stages
STAGE_EXPORTS = DESTDIR prefix exec_prefix bindir sbindir libexecdir datadir
STAGE_EXPORTS += sysconfdir sharedstatedir localstatedir libdir infodir lispdir
STAGE_EXPORTS += includedir oldincludedir mandir docdir sourcedir
STAGE_EXPORTS += CPPFLAGS CFLAGS LDFLAGS
STAGE_EXPORTS += CC CXX LD CPP AR AS NM RANLIB STRIP OBJCOPY OBJDUMP

CONFIGURE_ENV += $(foreach TTT,$(STAGE_EXPORTS),$(TTT)="$($(TTT))")
BUILD_ENV += $(foreach TTT,$(STAGE_EXPORTS),$(TTT)="$($(TTT))")
INSTALL_ENV += $(foreach TTT,$(STAGE_EXPORTS),$(TTT)="$($(TTT))")
MANIFEST_ENV += $(foreach TTT,$(STAGE_EXPORTS),$(TTT)="$($(TTT))")

# Global environment
export GARBUILD
export PATH LD_LIBRARY_PATH #LD_PRELOAD
export PKG_CONFIG_PATH

GARCHIVEROOT ?= $(mm_HOME)/source
GARCHIVEDIR = $(GARCHIVEROOT)/$(DISTNAME)
GARPKGROOT ?= /var/www/garpkg
GARPKGDIR = $(GARPKGROOT)/$(GARNAME)

# prepend the local file listing
FILE_SITES = file://$(FILEDIR)/ file://$(GARCHIVEDIR)/

#append the public archive
MASTER_SITES += http://linpvr.org/dnload/gar-source/

# Extra confs to include after gar.conf.mk
GAR_EXTRA_CONF += $(HOME)/.minimyth/minimyth.conf.mk minimyth.conf.mk extras/extras.conf.mk devel/gcc/package-api.mk

# Extra libs to include with gar.mk
GAR_EXTRA_LIBS += minimyth.lib.mk
