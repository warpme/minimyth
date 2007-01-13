GARNAME = splashutils
GARVERSION = 1.1.9.10
CATEGORIES = system
MASTER_SITES = http://dev.gentoo.org/~spock/projects/gensplash/archive/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME).patch.gar
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c kernel/linux lib/libjpeg lib/libpng lib/zlib lib/freetype

CONFIGURE_SCRIPTS = kernel
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

BUILD_ARGS = \
	KLCC="$(CC)" \
	CC="$(CC)" \
	CFLAGS="$(CFLAGS)" \
	LDFLAGS="$(LDFLAGS)" \
	STRIP="$(STRIP)" \
	LIBDIR="$(DESTDIR)$(libdir)"

GAR_EXTRA_CONF += kernel/linux/package-api.mk
include ../../gar.mk

configure-kernel:
	@rm -rf $(WORKSRC)/linux
	@ln -s $(DESTDIR)$(KERNEL_SOURCEDIR) $(WORKSRC)/linux
	@$(MAKECOOKIE)
