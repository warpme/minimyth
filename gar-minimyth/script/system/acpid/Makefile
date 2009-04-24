GARNAME = acpid
GARVERSION = 1.0.10
CATEGORIES = system
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

BUILD_SCRIPTS   = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = $(WORKSRC)/Makefile

BUILD_ARGS = \
	CFLAGS='$(CFLAGS) -DVERSION="\"$(GARVERSION)\"" -D_GNU_SOURCE'

BUILD_OVERRIDE_DIRS   = BINDIR SBINDIR MAN8DIR
INSTALL_OVERRIDE_DIRS = BINDIR SBINDIR MAN8DIR

include ../../gar.mk

BINDIR  := $(bindir)
SBINDIR := $(sbindir)
MAN8DIR := $(mandir)/man8

post-install:
	@chmod 755 $(DESTDIR)$(sbindir)/acpid
	@$(MAKECOOKIE)
