GARNAME = zlib
GARVERSION = 1.2.3
CATEGORIES = lib
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/libpng/
DISTFILES = $(DISTNAME).tar.gz license
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKDIR)/license

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = \
	--prefix=$(prefix) \
	--exec_prefix=$(exec_prefix) \
     	--libdir=$(libdir) \
	--includedir=$(includedir) \
	--shared
BUILD_ARGS     = \
	LIBS="libz.a libz.so.1.2.3"
INSTALL_ARGS   = \
	LIBS="libz.a libz.so.1.2.3"

INSTALL_OVERRIDE_DIRS = prefix exec_prefix libdir includedir mandir

include ../../gar.mk

CFLAGS := $(CFLAGS) -fPIC
AR     := $(AR) -rc

post-install:
	@rm -f $(DESTDIR)$(libdir)/libz.a
	@$(MAKECOOKIE)
