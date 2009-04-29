GARNAME = lcdproc
GARVERSION = 20090410Z
CATEGORIES = system
ifeq ($(GARVERSION),0.5.2)
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES  =
PATCHFILES += $(DISTNAME)-irtrans.patch
PATCHFILES += $(DISTNAME)-picolcd_4x20.patch
PATCHFILES += $(DISTNAME)-dm140_henlar_v0.2.patch $(DISTNAME)-imonlcd_0.3_with_send_fix.patch
else
MASTER_SITES = cvs://anonymous@$(GARNAME).cvs.sourceforge.net:/cvsroot/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES  =
PATCHFILES += $(DISTNAME)-dm140_henlar_v0.2.patch $(DISTNAME)-imonlcd_0.6.1.patch
endif
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/libftdi lib/libg15render lib/libirman lib/ncurses lib/libusb system/g15daemon system/lirc

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

ifeq ($(GARVERSION),0.5.2)
CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-libusb \
	--enable-drivers=all \
	--disable-doxygen \
	--disable-dot \
	--disable-html-dox \
	--disable-latex-dox \
	--with-libusb-libraries="$(DESTDIR)$(libdir)"
else
CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-libusb \
	--enable-libftdi \
	--enable-ethlcd \
	--disable-doxygen \
	--disable-dot \
	--disable-html-dox \
	--disable-latex-dox \
	--enable-drivers=all
endif

include ../../gar.mk

cvs//%/$(DISTNAME).tar.bz2:
	@$(call FETCH_CVS, $*, $(GARNAME), $(GARVERSION), $(DISTNAME))
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@$(MAKECOOKIE)

clean-all:
	@$(MAKE) clean
	@rm -rf $(DESTDIR)$(bindir)/lcdexec
	@rm -rf $(DESTDIR)$(bindir)/lcdident.pl
	@rm -rf $(DESTDIR)$(bindir)/lcdmetar.pl
	@rm -rf $(DESTDIR)$(bindir)/lcdproc
	@rm -rf $(DESTDIR)$(bindir)/lcdvc
	@rm -rf $(DESTDIR)$(sbindir)/LCDd
	@rm -rf $(DESTDIR)$(libdir)/lcdproc
	@rm -rf $(DESTDIR)$(sysconfdir)/LCDd.conf
