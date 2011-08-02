GARNAME = xwiimote
GARVERSION = 7341491
CATEGORIES = utils
MASTER_SITES = git://github.com/dvdhrm/xwiimote.git/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(GARNAME)-makefile.patch
LICENSE = Public_Domain

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c gtk/dbus-glib lib/dbus system/udev

BUILD_SCRIPTS     = $(WORKSRC)/makefile $(WORKSRC)/tools/makefile
INSTALL_SCRIPTS   = custom

include ../../gar.mk


git//%/$(DISTNAME).tar.bz2:
	@$(call FETCH_GIT, $*, $(GARVERSION), $(DISTNAME))
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE) 

install-custom:
	@mkdir -p $(DESTDIR)$(libdir)
	@rm -f $(DESTDIR)$(libdir)/libxwiimote.so
	@cp $(WORKSRC)/libxwiimote.so  $(DESTDIR)$(libdir)/libxwiimote.so
	@mkdir -p $(DESTDIR)$(bindir)
	@$(foreach tool, xwii xwiiconn xwiidump xwiishow, \
		rm -f $(DESTDIR)$(bindir)/$(tool) ; \
		cp $(WORKSRC)/tools/$(tool) $(DESTDIR)$(bindir)/$(tool) ; \
		chmod 0755 $(DESTDIR)$(bindir)/$(tool) ; \
	 )
	@$(MAKECOOKIE)
