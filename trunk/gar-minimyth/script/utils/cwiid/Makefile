GARNAME = cwiid
GARVERSION = 0.6.00
CATEGORIES = utils
MASTER_SITES = http://abstrakraft.org/cwiid/downloads/
DISTFILES = $(DISTNAME).tgz
PATCHFILES = $(DISTNAME)-hci_remote_name.patch $(DISTNAME)-rootdir.patch $(DISTNAME)-ioctl_ui_set_phys.patch $(DISTNAME)-wait_forever_sleep.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lib/bluez gtk/gtk+

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--without-python \
	--disable-ldconfig

include ../../gar.mk

# -Wl,--as-needed does not work when compiling wmgui.
LDFLAGS :=

pre-configure:
	@#cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libcwiid.a
	@$(MAKECOOKIE)
