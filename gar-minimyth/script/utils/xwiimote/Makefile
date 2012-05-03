GARNAME = xwiimote
GARVERSION = 20110222-54f4f1d
CATEGORIES = utils
MASTER_SITES = git://github.com/dvdhrm/xwiimote.git/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = BSD_2_Clause

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/ncurses system/udev

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-silent-rules \
	--enable-shared \
	--disable-static \
	--disable-debug \
	--with-gnu-ld

include ../../gar.mk

git//%/$(DISTNAME).tar.bz2:
	@$(call FETCH_GIT, $*, $(word 2,$(subst -, ,$(GARVERSION))), $(DISTNAME))
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE) 

pre-configure:
	@mkdir -p $(WORKSRC)/m4
	@$(call RUN_AUTOTOOLS)
	@$(call FIX_LIBTOOL,$(WORKSRC)/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libxwiimote.la
	@$(MAKECOOKIE)
