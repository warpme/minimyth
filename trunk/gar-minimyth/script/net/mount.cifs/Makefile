GARNAME = mount.cifs
GARVERSION = 11938
CATEGORIES = net
MASTER_SITES = svn://svnanon.samba.org/samba/branches/SAMBA_3_0/source/client/
DISTFILES = $(DISTNAME).tar.bz2 $(MAKEFILE)
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c kernel/linux

BUILD_SCRIPTS   = custom
INSTALL_SCRIPTS = custom

include ../../gar.mk

svn//%/$(DISTNAME).tar.bz2:
	@cd $(PARTIALDIR); rm -rf   $(GARNAME) $(DISTNAME)
	@cd $(PARTIALDIR); mkdir -p $(GARNAME) $(DISTNAME)
	@cd $(PARTIALDIR); svn co -r $(GARVERSION) svn://$* $(GARNAME)
	@cd $(PARTIALDIR); cp -f $(GARNAME)/mount.cifs.c $(DISTNAME)
	@cd $(PARTIALDIR); tar -jcf $(DISTNAME).tar.bz2 $(DISTNAME)
	@cd $(PARTIALDIR); rm -rf   $(GARNAME) $(DISTNAME)
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

build-custom:
	@$(BUILD_ENV) cd $(WORKSRC) ; $(CC) -o mount.cifs $(CFLAGS) mount.cifs.c
	@$(MAKECOOKIE)

install-custom:
	@$(INSTALL_ENV) install -m755 $(WORKSRC)/mount.cifs $(DESTDIR)$(esbindir)/mount.cifs
	@$(MAKECOOKIE)
