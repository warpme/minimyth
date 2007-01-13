GARNAME = make-bootstrap
GARVERSION = $(MAKE_VERSION)
CATEGORIES = devel
SOURCEPKG = devel/make
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

WORKSRC = $(WORKDIR)/make-$(GARVERSION)

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-nls
BUILD_ARGS     = LDFLAGS="-static"

GAR_EXTRA_CONF += devel/make/package-api.mk
include ../../gar.mk

CONFIGURE_ENV := DESTDIR="$(DESTDIR)" CC=cc
BUILD_ENV     := DESTDIR="$(DESTDIR)" CC=cc
INSTALL_ENV   := DESTDIR="$(DESTDIR)" CC=cc
