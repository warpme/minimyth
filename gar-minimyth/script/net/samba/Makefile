GARNAME = samba
GARVERSION = 3.0.20rc1
CATEGORIES = net
MASTER_SITES  = http://us1.samba.org/samba/ftp/stable/
MASTER_SITES += http://us1.samba.org/samba/ftp/rc/
MASTER_SITES += http://us1.samba.org/samba/ftp/pre/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c kernel/linux

WORKSRC = $(WORKDIR)/$(DISTNAME)/source

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile mount.cifs
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile mount.cifs

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-cups \
	--disable-xmltest \
	--with-privatedir=$(sysconfdir)/samba/private \
	--with-lockdir=$(localstatedir)/locks \
	--with-piddir=$(localstatedir)/locks \
	--with-swatdir=$(datadir)/samba/swat \
	--with-configdir=$(sysconfdir)/samba \
	--with-logfilebase=$(localstatedir)/log/samba \
	--with-libdir=$(libdir) \
	--with-mandir=$(mandir) \
	--with-smbmount

include ../../gar.mk

post-patch:
	@cd $(WORKDIR)/$(DISTNAME) ; patch -p1 < packaging/Debian/debian-stable/patches/smbmount-nomtab.patch
	@#Hack to allow configure to work. This works because we are not really cross compiling.
	@sed -i 's%\("$$cross_compiling" *= *\)yes%\1gar%' $(WORKSRC)/configure
	@$(MAKECOOKIE)

build-mount.cifs:
	@$(BUILD_ENV) cd $(WORKSRC)/client ; $(CC) -o mount.cifs $(CPPFLAGS) $(CFLAGS) $(LDFLAGS) -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64 -D_GNU_SOURCE mount.cifs.c
	@$(MAKECOOKIE)

install-mount.cifs:
	@$(INSTALL_ENV) install -m755 $(WORKSRC)/client/mount.cifs $(DESTDIR)$(esbindir)/mount.cifs
	@$(MAKECOOKIE)

post-install:
	@ln -s libsmbclient.so $(DESTDIR)$(libdir)/libsmbclient.so.0
	@mv -f $(DESTDIR)$(bindir)/smbmnt   $(DESTDIR)$(ebindir)/
	@mv -f $(DESTDIR)$(bindir)/smbmount $(DESTDIR)$(ebindir)/
	@rm -f $(DESTDIR)$(esbindir)/mount.smbfs ; ln -sf .$(call DIRSTODOTS,$(esbindir))$(ebindir)/smbmount $(DESTDIR)$(esbindir)/mount.smbfs
	@$(MAKECOOKIE)
