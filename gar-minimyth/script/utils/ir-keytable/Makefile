GARNAME = v4l-utils
GARVERSION = 0.8.8
CATEGORIES = utils
MASTER_SITES = http://linuxtv.org/downloads/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = \
	$(DISTNAME)-udev.patch
LICENSE = GPL2/LGPL2_1

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lang/cxx system/udev

BUILD_SCRIPTS   = $(WORKSRC)/utils/keytable/Makefile
INSTALL_SCRIPTS = $(WORKSRC)/utils/keytable/Makefile

BUILD_ARGS   = \
	DESTDIR="$(DESTDIR)" \
	PREFIX="$(prefix)" \
	LIBDIR="$(libdir)" \
	CPPFLAGS="$(CPPFLAGS)" \
	CFLAGS="$(CFLAGS) $(LDFLAGS)" \
	CXXFLAGS="$(CXXFLAGS) $(LDFLAGS)"
INSTALL_ARGS = \
	DESTDIR="$(DESTDIR)" \
	PREFIX="$(prefix)" \
	LIBDIR="$(libdir)"

CFLAGS   := $(CFLAGS)   -fPIC
CXXFLAGS := $(CXXFLAGS) -fPIC
LDFLAGS  := $(LDFLAGS)  -fPIC

include ../../gar.mk
