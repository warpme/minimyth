GARNAME = iputils
GARVERSION = s20070202
CATEGORIES = net
MASTER_SITES = http://www.skbuff.net/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME).patch
LICENSE = BSD

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

BUILD_SCRIPTS   = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = custom

BUILD_ARGS   = \
	LIBC_INCLUDE=$(includedir) \
	CC="$(CC)" \
	ping

include ../../gar.mk

install-custom:
	@mkdir -p $(DESTDIR)$(ebindir)
	@install -m 755 $(WORKSRC)/ping $(DESTDIR)$(ebindir)
	@$(MAKECOOKIE)
