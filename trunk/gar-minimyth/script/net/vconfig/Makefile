GARNAME = vconfig
GARVERSION = 1.9
CATEGORIES = net
MASTER_SITES = http://www.candelatech.com/~greear/vlan/
DISTFILES = vlan.$(GARVERSION).tar.gz
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

WORKSRC = $(WORKDIR)/vlan

BUILD_SCRIPTS   = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = custom

BUILD_ARGS = \
	CCFLAGS="$(CFLAGS) -D_GNU_SOURCE" \
	STRIP="$(STRIP)" \
	CC="$(CC)" \
	CCC="$(CXX)" \
	vconfig

include ../../gar.mk

post-extract:
	@rm -f $(WORKSRC)/macvlan_config
	@rm -f $(WORKSRC)/vconfig
	@rm -f $(WORKSRC)/vconfig.o
	@$(MAKECOOKIE)

install-custom:
	@mkdir -p $(DESTDIR)$(esbindir)
	@install -m 755 $(WORKSRC)/vconfig $(DESTDIR)$(esbindir)
	@$(MAKECOOKIE)
