GARNAME = acpid
GARVERSION = 1.0.4
CATEGORIES = system
MASTER_SITES = http://unc.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

BUILD_SCRIPTS   = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = $(WORKSRC)/Makefile

BINDIR     = $(bindir)
SBINDIR    = $(sbindir)
MAN8DIR    = $(mandir)/man8

INSTALL_OVERRIDE_DIRS = BINDIR SBINDIR MAN8DIR

include ../../gar.mk

post-install:
	@chmod 755 $(DESTDIR)$(sbindir)/acpid
	@$(MAKECOOKIE)
