GARNAME = libtirpc
GARVERSION = 0.2.2
CATEGORIES = net
MASTER_SITES = http://downloads.sourceforge.net/project/$(GARNAME)/$(GARNAME)/$(GARVERSION)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-remove_des.patch
LICENSE = BSD_3_Clause

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c devel/glibc-rpcsvc

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-gss \
	--enable-shared \
	--disable-static \
	--with-gnu-ld

include ../../gar.mk

# Fails to compile using the gold linker.
CFLAGS  := $(filter-out -fuse-ld=gold -fuse-linker-plugin, $(CFLAGS))
LDFLAGS := $(filter-out -fuse-ld=gold -fuse-linker-plugin, $(LDFLAGS))

pre-configure:
	@$(call RUN_AUTOTOOLS)
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/$(GARNAME).la
	@$(MAKECOOKIE)