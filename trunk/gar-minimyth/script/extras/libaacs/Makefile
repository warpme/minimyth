GARNAME = libaacs
GARVERSION = 29b3e517f943a85f7a4acd8a00c5307d7392b8a2
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
