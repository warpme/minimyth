GARNAME = lcdproc
GARVERSION = 0.5.6
CATEGORIES = system
MASTER_SITES = http://downloads.sourceforge.net/project/$(GARNAME)/$(GARNAME)/$(GARVERSION)/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-dm140_henlar_v0.2.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/libftdi lib/libg15render lib/libirman lib/ncurses lib/freetype lib/libpng lib/libusb lib/libusb-compat system/g15daemon system/lirc

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-libusb \
	--disable-libusb-1-0 \
	--enable-libftdi \
	--disable-libhid \
	--enable-libpng \
	--enable-freetype \
	--disable-freetypetest \
	--enable-ethlcd \
	--disable-doxygen \
	--disable-dot \
	--disable-html-dox \
	--disable-latex-dox \
	--enable-drivers=all

include ../../gar.mk

cvs//%/$(DISTNAME).tar.bz2:
	@$(call FETCH_CVS, $*, $(GARNAME), $(GARVERSION), $(DISTNAME))
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

pre-configure:
	@$(call RUN_AUTOTOOLS)
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
	@rm -rf $(DESTDIR)$(libexecdir)/lcdproc
	@rm -rf $(DESTDIR)$(sysconfdir)/LCDd.conf
	@rm -rf $(DESTDIR)$(sysconfdir)/lcdexec.conf
	@rm -rf $(DESTDIR)$(sysconfdir)/lcdproc.conf
	@rm -rf $(DESTDIR)$(sysconfdir)/lcdvc.conf
	@rm -rf $(DESTDIR)$(licensedir)/lcdproc
	@rm -rf $(DESTDIR)$(versiondir)/lcdproc
	@rm -rf $(DESTDIR)$(mandir)/man1/lcdexec.1
	@rm -rf $(DESTDIR)$(mandir)/man1/lcdproc.1
	@rm -rf $(DESTDIR)$(mandir)/man1/lcdvc.1
	@rm -rf $(DESTDIR)$(mandir)/man5/lcdproc-config.5
	@rm -rf $(DESTDIR)$(mandir)/man6/lcdscrub.6
	@rm -rf $(DESTDIR)$(mandir)/man8/LCDd.8
