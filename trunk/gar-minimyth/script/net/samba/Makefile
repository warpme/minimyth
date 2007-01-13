GARNAME = samba
GARVERSION = 2.2.12
CATEGORIES = net
MASTER_SITES = http://us1.samba.org/samba/ftp/stable/
DISTFILES = $(GARNAME)-$(GARVERSION).tar.gz
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c kernel/linux

WORKSRC = $(WORKDIR)/$(DISTNAME)/source

BASEDIR    = $(exec_prefix)
BINDIR     = $(bindir)
DATADIR    = $(datadir)
SBINDIR    = $(sbindir)
LIBDIR     = $(libdir)
VARDIR     = $(localstatedir)
CONFIGDIR  = $(sysconfdir)
MANDIR     = $(mandir)
INCLUDEDIR = $(includedir)

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) --target=$(GARTARGET) \
	--with-smbmount \
	--disable-cups

BUILD_OVERRIDE_DIRS   = \
	BASEDIR BINDIR DATADIR SBINDIR LIBDIR VARDIR CONFIGDIR MANDIR INCLUDEDIR \
	prefix exec_prefix mandir sysconfdir
INSTALL_OVERRIDE_DIRS = \
	BASEDIR BINDIR DATADIR SBINDIR LIBDIR VARDIR CONFIGDIR MANDIR INCLUDEDIR \
	prefix exec_prefix mandir sysconfdir

include ../../gar.mk

post-install:
	@rm -f $(DESTDIR)$(esbindir)/smbmount ; mv     $(DESTDIR)$(BINDIR)/smbmount $(DESTDIR)$(esbindir)/smbmount
	@rm -f $(DESTDIR)/sbin/mount.smbfs    ; ln -sf $(esbindir)/smbmount $(DESTDIR)$(esbindir)/mount.smbfs
	@$(MAKECOOKIE)
