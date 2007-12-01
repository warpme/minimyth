GARNAME = rsync
GARVERSION = 2.6.9
CATEGORIES = net
MASTER_SITES = http://samba.anu.edu.au/ftp/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-debug \
	--disable-profile \
	--disable-maintainer-mode \
	--enable-largefile \
	--disable-ipv6 \
	--enable-locale \
	--with-included-popt \
	--with-rysync-path=rsync \
	--with-rsyncd-conf-path=$(sysconfdir)/rsyncd.conf \
	--with-rsh=ssh \
	--with-nobody-group=nobody

include ../../gar.mk
