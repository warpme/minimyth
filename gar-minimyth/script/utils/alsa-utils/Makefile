GARNAME = alsa-utils
GARVERSION = 1.0.19
CATEGORIES = utils
MASTER_SITES = ftp://ftp.alsa-project.org/pub/utils/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME).patch.gar
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/alsa-lib lib/ncursesw

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-nls \
	--disable-rpath \
	--disable-alsatest \
	--enable-alsamixer \
	--enable-alsaconf \
	--disable-xmlto \
	--enable-largefile \
	--with-gnu-ld \
	--with-curses=ncursesw

CONFIGURE_ENV = \
	ncursesw5_config='yes'

include ../../gar.mk

pre-configure:
	@$(call FIX_LIBTOOL_LIBPATH,$(WORKSRC),configure)
	@$(MAKECOOKIE)
