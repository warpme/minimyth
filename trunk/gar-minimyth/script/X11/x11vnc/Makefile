GARNAME = x11vnc
GARVERSION = 0.8
CATEGORIES = X11
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/libvncserver/
DISTFILES = $(DISTNAME).tar.gz
LICENSE =

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c xorg/xorg lib/libjpeg lib/zlib

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes=$(DESTDIR)$(includedir) \
	--x-libraries=$(DESTDIR)$(libdir) \
	--with-x

include ../../gar.mk
