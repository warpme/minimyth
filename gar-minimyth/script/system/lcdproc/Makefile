GARNAME = lcdproc
GARVERSION = 0.5.2
CATEGORIES = system
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-henlar-v0.2.patch $(DISTNAME)-imonlcd_0.3_with_send_fix.patch $(DISTNAME)-irtrans.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/libftdi lib/libg15render lib/libirman lib/ncurses lib/libusb system/g15daemon system/lirc

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-libusb \
	--enable-drivers=all \
	--with-libusb-libraries="$(DESTDIR)$(libdir)"

include ../../gar.mk

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(MAKECOOKIE)
