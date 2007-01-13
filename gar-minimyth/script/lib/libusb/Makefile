GARNAME = libusb
GARVERSION = 0.1.9
CATEGORIES = lib
MASTER_SITES = http://unc.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-DESTDIR.patch
LICENSE = LGPL2_1

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c X11/X11 qt/qt

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes=$(DESTDIR)$(x11includedir) \
	--x-libraries=$(DESTDIR)$(x11libdir) \
	--disable-debug \
	--disable-build-docs \
	--with-gnu-ld \
	--with-qt \
	--with-x \
	--with-qt-dir=$(DESTDIR)$(qtprefix) \
	--with-qt-includes=$(DESTDIR)$(qtincludedir) \
	--with-qt-libraries=$(DESTDIR)$(qtlibdir)

include ../../gar.mk

pre-configure:
	@cd $(WORKSRC) ; aclocal
	@cd $(WORKSRC) ; libtoolize --copy --force
	@cd $(WORKSRC) ; autoconf
	$(MAKECOOKIE)

post-install:
	rm -f $(DESTDIR)$(libdir)/libusb.la
	$(MAKECOOKIE)
