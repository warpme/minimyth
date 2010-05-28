GARNAME = acpid
GARVERSION = 2.0.5
CATEGORIES = system
MASTER_SITES  = http://easynews.dl.sourceforge.net/sourceforge/$(GARNAME)/
MASTER_SITES += http://www.tedfelix.com/linux/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

BUILD_SCRIPTS   = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = $(WORKSRC)/Makefile

BUILD_ARGS   = \
	OPT="$(CFLAGS)" \
	BINDIR=$(bindir) \
	SBINDIR=$(sbindir) \
	MAN8DIR=$(mandir)/man8 \
	DOCDIR=$(docdir)/acpid
INSTALL_ARGS = \
	BINDIR=$(bindir) \
	SBINDIR=$(sbindir) \
	MAN8DIR=$(mandir)/man8 \
	DOCDIR=$(docdir)/acpid

include ../../gar.mk

# acpid 2.0.5 fails to compile with GCC 4.5.0's link time optimization.
CFLAGS  := $(filter-out -flto -fuse-linker-plugin, $(CFLAGS))
LDFLAGS := $(filter-out -flto -fuse-linker-plugin, $(LDFLAGS))

CFLAGS := $(filter-out -ffast-math, $(CFLAGS))
post-install:
	@chmod 755 $(DESTDIR)$(sbindir)/acpid
	@$(MAKECOOKIE)
