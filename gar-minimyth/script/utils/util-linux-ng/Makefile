GARNAME = util-linux-ng
GARVERSION = v2.13-pre7
CATEGORIES = utils
MASTER_SITES = git://git.kernel.org/pub/scm/utils/util-linux-ng/util-linux-ng.git/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-swap_configure.patch $(DISTNAME)-libncursesw.patch
LICENSE = BSD/GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/ncurses lib/zlib utils/procps disk/e2fsprogs

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-use-tty-group \
	--with-gnu-ld
BUILD_ARGS     = \
	usrbinexecdir=$(usrbinexecdir) \
	usrsbinexecdir=$(usrsbinexecdir) \
	datadir=$(datadir) \
	infodir=$(infodir) \
	mandir=$(mandir)
INSTALL_ARGS   = \
	usrbinexecdir=$(usrbinexecdir) \
	usrsbinexecdir=$(usrsbinexecdir) \
	datadir=$(datadir) \
	infodir=$(infodir) \
	mandir=$(mandir)

include ../../gar.mk

usrbinexecdir  := $(bindir)
usrsbinexecdir := $(sbindir)
bindir         := $(ebindir)
sbindir        := $(esbindir)
libdir         := $(elibdir)

git//%/$(DISTNAME).tar.bz2:
	@$(call FETCH_GIT, $*, $(GARVERSION), $(DISTNAME))
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

pre-configure:
	@cd $(WORKSRC) ; autoreconf --verbose --install --force
	@rm -f $(WORKSRC)/config.cache
	@$(MAKECOOKIE)
