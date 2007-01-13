GARNAME = x11vnc
GARVERSION = 0.7.1
CATEGORIES = X11
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/libvncserver/
DISTFILES = $(DISTNAME).tar.gz
LICENSE =

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c X11/X11 lib/libjpeg lib/zlib

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes=$(DESTDIR)$(x11includedir) \
	--x-libraries=$(DESTDIR)$(x11libdir)

include ../../gar.mk
