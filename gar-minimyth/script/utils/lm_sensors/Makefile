GARNAME = lm_sensors
GARVERSION = 3.4.0
CATEGORIES = utils
MASTER_SITES = http://dl.lm-sensors.org/lm-sensors/releases/
DISTFILES   = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-perl.patch.gar
LICENSE = GPL2/LGPL2_1

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

BUILD_SCRIPTS   = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = $(WORKSRC)/Makefile

ARGS = \
	DESTDIR="$(DESTDIR)" \
	PREFIX="$(prefix)" \
	CC="$(CC)" \
	ETCDIR="$(sysconfdir)" \
	LIBDIR="$(libdir)" \
	EXLDFLAGS="" \
	BINDIR="$(bindir)" \
	SBINDIR="$(sbindir)" \
	INCLUDEDIR="$(includedir)" \
	LIBINCLUDEDIR="$(includedir)/sensors" \
	MANDIR="$(mandir)" \
	MACHINE="$(GARCH)" \
	CFLAGS="$(CFLAGS)" \
	CPPFLAGS="$(CPPFLAGS)" \
	AR="$(AR)"

BUILD_ARGS   = $(ARGS)
INSTALL_ARGS = $(ARGS)

include ../../gar.mk

CFLAGS  := $(CFLAGS)  -fPIC
LDFLAGS := $(LDFLAGS) -fPIC

pre-install:
	@rm -rf $(DESTDIR)/$(sysconfdir)/sensors3.conf
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libsensors.a
	@$(MAKECOOKIE)
