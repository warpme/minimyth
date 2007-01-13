GARNAME = blackbox
GARVERSION = 0.70.0beta2
CATEGORIES = X11
MASTER_SITES = http://telia.dl.sourceforge.net/sourceforge/blackboxwm/
DISTFILES = $(GARNAME)-$(GARVERSION).tar.gz
LICENSE = MIT

DESCRIPTION =
define BLURB
endef

DEPENDS   = lang/c X11/freetype X11/X11
BUILDDEPS = devel/pkgconfig

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) --target=$(GARTARGET) \
	--x-includes=$(DESTDIR)$(x11includedir) \
	--x-libraries=$(DESTDIR)$(x11libdir)

CONFIGURE_ENV  = \
	PKG_CONFIG_PATH=$(DESTDIR)$(libdir)/pkgconfig:$(DESTDIR)$(x11libdir)/pkgconfig

include ../../gar.mk

post-install:
	@rm -f $(DESTDIR)$(libdir)/libbt.la
	@sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'         $(DESTDIR)$(libdir)/pkgconfig/libbt.pc
	@sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g' $(DESTDIR)$(libdir)/pkgconfig/libbt.pc
	@$(MAKECOOKIE)
