GARNAME = gcc-bootstrap
GARVERSION = $(GCC_VERSION)
CATEGORIES = devel
SOURCEPKG = devel/gcc
LICENSE = GPL2/LGPL2_1

DESCRIPTION = 
define BLURB
endef

export GCC_DISABLE_PATCH := yes

BUILDDEPS = devel/make-bootstrap devel/binutils-bootstrap

WORKSRC = $(WORKDIR)/gcc-$(GARVERSION)

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) --target=$(GARTARGET) \
	--with-local-prefix=$(patsubst %/include,%,$(includedir)) \
	--disable-nls \
	--enable-shared \
	--enable-languages=c \
	--enable-version-specific-runtime-libs

BUILD_ARGS = BOOT_LDFLAGS="-static" bootstrap

GAR_EXTRA_CONF += devel/gcc/package-api.mk
include ../../gar.mk

CONFIGURE_ENV := DESTDIR="$(DESTDIR)" CC=cc
BUILD_ENV     := DESTDIR="$(DESTDIR)" CC=cc
INSTALL_ENV   := DESTDIR="$(DESTDIR)" CC=cc

post-install:
	ln -sf gcc $(DESTDIR)$(bindir)/cc
	$(MAKECOOKIE)
