GARNAME = lm_sensors
GARVERSION = 3.1.2
CATEGORIES = utils
MASTER_SITES  = http://dl.lm-sensors.org/lm-sensors/releases/
MASTER_SITES += svn://lm-sensors.org/svn/lm-sensors/trunk/
DISTFILES   = $(DISTNAME).tar.bz2
PATCHFILES  = \
	$(DISTNAME)-commit_5832.patch \
	$(DISTNAME)-commit_5835.patch
PATCHFILES += $(DISTNAME)-perl.patch.gar
LICENSE = GPL2

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

# lm_sensors 3.1.2 fails to compile with GCC 4.5.0's link time optimization (x86_64 has fPIC related error).
CFLAGS := $(filter-out -flto -fuse-linker-plugin, $(CFLAGS))

svn//%/$(DISTNAME).tar.bz2:
	@$(call FETCH_SVN, http://$*, $(GARVERSION), $(DISTNAME))
	@$(MAKECOOKIE)

x-checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

pre-install:
	@rm -rf $(DESTDIR)/$(sysconfdir)/sensors3.conf
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libsensors.a
	@$(MAKECOOKIE)
