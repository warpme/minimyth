GARNAME = lm_sensors
GARVERSION = 2.10.5
CATEGORIES = utils
MASTER_SITES  = http://dl.lm-sensors.org/lm-sensors/releases/
MASTER_SITES += svn://lm-sensors.org/svn/lm-sensors/trunk/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-i2c_dev_h.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c kernel/kernel lib/sysfsutils

BUILD_SCRIPTS   = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = custom

ARGS = \
	KERNELVERSION="$(LINUX_FULL_VERSION)" \
	LINUX="$(DESTDIR)$(LINUX_BUILDDIR)" \
	I2C_HEADERS="$(DESTDIR)$(includedir)" \
	DESTDIR="$(DESTDIR)" \
	PREFIX="$(prefix)" \
	CC="$(CC)" \
	MODPREF="$(DESTDIR)$(LINUX_MODULESDIR)" \
	ETCDIR="$(sysconfdir)" \
	LIBDIR="$(libdir)" \
	EXLDFLAGS="" \
	BINDIR="$(bindir)" \
	SBINDIR="$(sbindir)" \
	INCLUDEDIR="$(includedir)" \
	MANDIR="$(mandir)" \
	MACHINE="$(GARCH)" \
	LIBICONV=""

BUILD_ARGS   = $(ARGS) user
INSTALL_ARGS = $(ARGS)

GAR_EXTRA_CONF += kernel-$(mm_KERNEL_VERSION)/linux/package-api.mk
include ../../gar.mk

svn//%/$(DISTNAME).tar.bz2:
	@$(call FETCH_SVN, http://$*, $(GARVERSION), $(DISTNAME))
	@$(MAKECOOKIE)

x-checksum-$(DISTNAME).tar.bz2:
	@$(MAKECOOKIE)

pre-install:
	@rm -rf $(DESTDIR)/$(sysconfdir)/sensors.conf
	@$(MAKECOOKIE)

install-custom:
	@$(INSTALL_ENV) $(MAKE) DESTDIR=$(DESTDIR) $(foreach TTT,$(INSTALL_OVERRIDE_DIRS),$(TTT)="$(DESTDIR)$($(TTT))") -C $(WORKSRC) $(INSTALL_ARGS) user_install
	@$(MAKECOOKIE)
