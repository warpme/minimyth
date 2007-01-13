GARNAME = mythtv
GARVERSION = $(MYTHTV_VERSION)
CATEGORIES = myth
MASTER_SITES = cvs://mythtv:mythtv@cvs.mythtv.org:/var/lib/mythcvs/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME).patch.gar $(DISTNAME)-settings.patch.gar $(DISTNAME)-fadeaway.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lang/c++ lib/lame lib/alsa-lib db/mysql X11/freetype X11/X11 qt/qt lirc/lirc

CONFIGURE_SCRIPTS += $(WORKSRC)/configure
CONFIGURE_SCRIPTS += $(WORKSRC)/mythtv
BUILD_SCRIPTS     += $(WORKSRC)/Makefile
INSTALL_SCRIPTS   += $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) \
	--cross-prefix=$(compiler_prefix) \
	--cpu=$(KERNEL_ARCH) \
	--extra-cflags="$(CFLAGS)" \
	--extra-ldflags="$(LDFLAGS)"
CONFIGURE_ENV += \
	DESTDIR="$(DESTDIR)" \
	QTDIR="$(DESTDIR)$(qtprefix)" \
	OPTFLAGS="$(CFLAGS)"
BUILD_ENV     += \
	DESTDIR="$(DESTDIR)" \
	QTDIR="$(DESTDIR)$(qtprefix)" \
	OPTFLAGS="$(CFLAGS)"
INSTALL_ARGS  += \
	INSTALL_ROOT="$(DESTDIR)"

GAR_EXTRA_CONF += kernel/linux/package-api.mk myth/mythtv/package-api.mk
include ../../gar.mk

cvs//%/$(DISTNAME).tar.bz2:
	@cd $(PARTIALDIR); rm -rf $(GARNAME)
	@cd $(PARTIALDIR); cvs -z3 -d:pserver:$* co -D $(GARVERSION) $(GARNAME)
	@cd $(PARTIALDIR); rm -rf $(DISTNAME)
	@cd $(PARTIALDIR); mv $(GARNAME) $(DISTNAME)
	@cd $(PARTIALDIR); tar -jc $(DISTNAME) -f $(DISTNAME).tar.bz2
	@cd $(PARTIALDIR); rm -rf $(DISTNAME)
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

configure-%/mythtv:
	@cd $* ; $(CONFIGURE_ENV) qmake $(GARNAME).pro
	@$(MAKECOOKIE)
