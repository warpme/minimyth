GARNAME = xbindkeys
GARVERSION = 1.8.3
CATEGORIES = X11
MASTER_SITES = http://www.nongnu.org/xbindkeys/
DISTFILES = $(DISTNAME).tar.gz
#PATCHFILES = $(DISTNAME)-getline.patch $(DISTNAME)-staticgravity.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c xorg/xorg

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes=$(DESTDIR)$(includedir) \
	--x-libraries=$(DESTDIR)$(libdir) \
	--disable-tk \
	--enable-fork \
	--disable-tk \
	--disable-guile \
	--with-x

CONFIGURE_ENV  =
ifneq ("$(DESTIMG)","build")
CONFIGURE_ENV += \
	ac_cv_func_malloc_0_nonnull=yes
endif

include ../../gar.mk

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)
