GARNAME = ratpoison
GARVERSION = 1.4.5
CATEGORIES = X11
MASTER_SITES = http://savannah.nongnu.org/download/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-getline.patch $(DISTNAME)-staticgravity.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c xorg/xorg X11/rxvt

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes=$(DESTDIR)$(includedir) \
	--x-libraries=$(DESTDIR)$(libdir) \
	--disable-debug \
	--disable-history \
	--with-xterm=rxvt \
	--with-xft \
	--with-x

include ../../gar.mk

# Suffers from bug 42453 <http://gcc.gnu.org/bugzilla/show_bug.cgi?id=42453>.
CFLAGS  := $(filter-out -fuse-linker-plugin, $(CFLAGS))
LDFLAGS := $(filter-out -fuse-linker-plugin, $(LDFLAGS))

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)
