GARNAME = ncurses
GARVERSION = $(NCURSES_VERSION)
CATEGORIES = lib
MASTER_SITES = ftp://ftp.gnu.org/gnu/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-perl.patch.gar $(DISTNAME).patch
LICENSE = MIT_Modified

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS  = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--without-cxx-binding \
	--without-ada \
	--without-ada-compiler \
	--with-build-cc="$(build_CC)" \
	--with-build-cppflags="$(build_CPPFLAGS)" \
	--with-build-cflags="$(build_CFLAGS)" \
	--with-build-ldflags="$(build_LDFLAGS)" \
	--with-build-libs="" \
	--with-shared \
	--disable-rpath \
	--disable-widec \
	--enable-termcap
ifneq ($(DESTIMG),build)
CONFIGURE_ARGS += \
	--without-progs
endif

include ../../gar.mk

post-install:
	@cd $(DESTDIR)$(libdir) && ln -sf libncurses.so libtermcap.so
	@$(MAKECOOKIE)
