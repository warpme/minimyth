GARNAME = xf86-input-evtouch
GARVERSION = 0.8.7
CATEGORIES = $(CATEGORY)
MASTER_SITES = http://www.stz-softwaretechnik.de/~ke/touchscreen/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-pkg_config.patch $(DISTNAME).patch $(DISTNAME)-dbg.patch
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/COPYING

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c \
	$(CATEGORY)/libX11 \
	$(CATEGORY)/xorg-server \
	$(CATEGORY)/xproto
BUILDDEPS = \
	$(CATEGORY)/util-macros \
	$(CATEGORY)/xorg-server \
	$(CATEGORY)/xorg-sgml-doctools

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-evcalibrate \
	--with-gnu-ld

CONFIGURE_ENV = \
	CURSORDIR="$(datadir)/$(GARNAME)"

GAR_EXTRA_CONF += $(CATEGORY)/xorg/package-api.mk
include ../../gar.mk

pre-configure:
	@rm -f $(WORKSRC)/acinclude.m4
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/xorg/modules/input/evtouch_drv.la
	@mv -f  $(DESTDIR)$(libdir)/$(GARNAME)/calibrate.sh $(DESTDIR)$(bindir)/ev_calibrate.sh
	@mv -f  $(DESTDIR)$(libdir)/$(GARNAME)/ev_calibrate $(DESTDIR)$(bindir)/ev_calibrate
	@rm -fr $(DESTDIR)$(libdir)/$(GARNAME)
	@$(MAKECOOKIE)
