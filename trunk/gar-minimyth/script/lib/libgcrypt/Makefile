GARNAME = libgcrypt
GARVERSION = 1.4.3
CATEGORIES = lib
MASTER_SITES = ftp://ftp.gnupg.org/gcrypt/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME).patch.gar
LICENSE = GPL2/LGPL2_1

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/libgpg-error

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-shared \
	--disable-static \
	--disable-asm \
	--with-gnu-ld \
	--with-gpg-error-prefix="$(DESTDIR)$(prefix)" \
	--with-pth-prefix="$(DESTDIR)$(prefix)"

include ../../gar.mk

LDFLAGS :=

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/$(GARNAME).la
	@$(MAKECOOKIE)
