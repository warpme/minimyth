GARNAME = libxcb
GARVERSION = 1.1
CATEGORIES = $(CATEGORY)
MASTER_SITES = http://xcb.freedesktop.org/dist/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-perl.patch.gar $(DISTNAME)-pkg_config.patch
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/COPYING

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c \
	$(CATEGORY)/libpthread-stubs \
	$(CATEGORY)/libXau \
	$(CATEGORY)/xcb-proto
BUILDDEPS = lib/libxslt

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

CONFIGURE_SCRIPTS  = $(WORKSRC)/configure
BUILD_SCRIPTS      = $(WORKSRC)/Makefile
INSTALL_SCRIPTS    = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-build-docs \
	--with-gnu-ld

GAR_EXTRA_CONF += $(CATEGORY)/xorg/package-api.mk
include ../../gar.mk

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libxcb.la
	@rm -f $(DESTDIR)$(libdir)/libxcb-composite.la
	@rm -f $(DESTDIR)$(libdir)/libxcb-damage.la
	@rm -f $(DESTDIR)$(libdir)/libxcb-dpms.la
	@rm -f $(DESTDIR)$(libdir)/libxcb-glx.la
	@rm -f $(DESTDIR)$(libdir)/libxcb-randr.la
	@rm -f $(DESTDIR)$(libdir)/libxcb-record.la
	@rm -f $(DESTDIR)$(libdir)/libxcb-render.la
	@rm -f $(DESTDIR)$(libdir)/libxcb-res.la
	@rm -f $(DESTDIR)$(libdir)/libxcb-screensaver.la
	@rm -f $(DESTDIR)$(libdir)/libxcb-shape.la
	@rm -f $(DESTDIR)$(libdir)/libxcb-shm.la
	@rm -f $(DESTDIR)$(libdir)/libxcb-sync.la
	@rm -f $(DESTDIR)$(libdir)/libxcb-xevie.la
	@rm -f $(DESTDIR)$(libdir)/libxcb-xf86dri.la
	@rm -f $(DESTDIR)$(libdir)/libxcb-xfixes.la
	@rm -f $(DESTDIR)$(libdir)/libxcb-xinerama.la
	@rm -f $(DESTDIR)$(libdir)/libxcb-xlib.la
	@rm -f $(DESTDIR)$(libdir)/libxcb-xprint.la
	@rm -f $(DESTDIR)$(libdir)/libxcb-xtest.la
	@rm -f $(DESTDIR)$(libdir)/libxcb-xv.la
	@rm -f $(DESTDIR)$(libdir)/libxcb-xvmc.la
	@$(MAKECOOKIE)
