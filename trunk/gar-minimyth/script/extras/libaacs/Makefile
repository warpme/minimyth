GARNAME = libaacs
GARVERSION = 339b6db5571e42d8e27459e6175e7aa0e603c8ea
CATEGORIES = extras
MASTER_SITES = git://git.videolan.org/libaacs.git/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(GARNAME)-gpg_error.patch
LICENSE = LGPL2_1

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c lib/libgcrypt
BUILDDEPS =

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-werror \
	--disable-extra-warnings \
	--disable-optimizations \
	--disable-debug \
	--enable-shared \
	--disable-static \
	--with-gnu-ld

include ../../gar.mk
include ../extras.mk

git//%$(DISTNAME).tar.bz2:
	@$(call FETCH_GIT, $*, $(GARVERSION), $(DISTNAME))
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE) 

pre-configure:
	@$(call RUN_AUTOTOOLS)
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(extras_libdir)/$(GARNAME).la
	@$(MAKECOOKIE)
