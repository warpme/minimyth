GARNAME = mount.cifs
GARVERSION = 22982
CATEGORIES = net
MASTER_SITES = svn://svnanon.samba.org/samba/branches/SAMBA_3_0/source/client/
DISTFILES = $(DISTNAME).tar.bz2 $(MAKEFILE)
PATCHFILES = $(DISTNAME)-limits_h.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

BUILD_SCRIPTS   = custom
INSTALL_SCRIPTS = custom

include ../../gar.mk

svn//%/$(DISTNAME).tar.bz2:
	@$(call FETCH_SVN, svn://$*, $(GARVERSION), $(DISTNAME))
	@cd $(PARTIALDIR); rm -rf   $(DISTNAME)
	@cd $(PARTIALDIR); tar -jxf $(DISTNAME).tar.bz2
	@cd $(PARTIALDIR); rm -rf   $(DISTNAME)~
	@cd $(PARTIALDIR); mv       $(DISTNAME) $(DISTNAME)~
	@cd $(PARTIALDIR); mkdir -p $(DISTNAME)
	@cd $(PARTIALDIR); cp -f    $(DISTNAME)~/mount.cifs.c $(DISTNAME)
	@cd $(PARTIALDIR); rm -rf   $(DISTNAME)~
	@cd $(PARTIALDIR); rm -rf   $(DISTNAME).tar.bz2
	@cd $(PARTIALDIR); tar -jcf $(DISTNAME).tar.bz2 $(DISTNAME)
	@cd $(PARTIALDIR); rm -rf   $(DISTNAME)
	@$(MAKECOOKIE)

checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

build-custom:
	@$(BUILD_ENV) cd $(WORKSRC) ; $(CC) -o mount.cifs $(CFLAGS) mount.cifs.c
	@$(MAKECOOKIE)

install-custom:
	@$(INSTALL_ENV) install -m755 $(WORKSRC)/mount.cifs $(DESTDIR)$(esbindir)/mount.cifs
	@$(MAKECOOKIE)
