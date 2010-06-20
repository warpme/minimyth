GARNAME = libvpx
GARVERSION = 0.9.1
CATEGORIES = lib
MASTER_SITES = http://webm.googlecode.com/files/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/LICENSE

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = \
	--log \
	$(if $(filter i386, $(GARCH_FAMILY)), --target=x86-linux-gcc) \
	$(if $(filter x86_64, $(GARCH_FAMILY)), --target=x86_64-linux-gcc) \
	--cpu=$(GARCH) \
	--enable-extra-warnings \
	--disable-werror \
	--enable-optimizations \
	--enable-pic \
	--disable-ccache \
	--disable-debug \
	--disable-gprof \
	--disable-gcov \
	--disable-install-docs \
	--enable-install-bins  \
	--enable-install-libs \
	--disable-install-srcs \
	--enable-libs \
	--disable-examples \
	--enable-runtime-cpu-detect \
	--enable-shared
BUILD_ARGS     = \
	verbose=1
INSTALL_ARGS   = \
	verbose=1

include ../../gar.mk

LD := $(CC)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libvpx.a
	@$(MAKECOOKIE)
