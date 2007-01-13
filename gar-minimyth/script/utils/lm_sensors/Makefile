GARNAME = lm_sensors
GARVERSION = 2.9.0
CATEGORIES = utils
MASTER_SITES = http://secure.netroedge.com/~lm78/archive/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c kernel/linux

BUILD_SCRIPTS   = $(WORKSRC)/Makefile
INSTALL_SCRIPTS = custom

ARGS = \
	LINUX="$(DESTDIR)$(KERNEL_BUILDDIR)" \
	MODPREF="$(DESTDIR)$(KERNEL_MODULESDIR)" \
	KERNELVERSION="$(KERNEL_FULL_VERSION)" \
	CC="$(CC)" \
	AR="$(AR)" \
	EXLDFLAGS="" \
	MACHINE="$(GARCH)" \
	I2C_HEADERS="$(DESTDIR)$(includedir)" \
	PREFIX="$(prefix)" \
	ETCDIR="$(sysconfdir)" \
	LIBDIR="$(libdir)" \
	BINDIR="$(bindir)" \
	SBINDIR="$(sbindir)" \
	INCLUDEDIR="$(includedir)" \
	MANDIR="$(mandir)"

BUILD_ARGS   = $(ARGS) user
INSTALL_ARGS = $(ARGS)

GAR_EXTRA_CONF += kernel/linux/package-api.mk
include ../../gar.mk

install-custom:
	@$(INSTALL_ENV) $(MAKE) DESTDIR=$(DESTDIR) $(foreach TTT,$(INSTALL_OVERRIDE_DIRS),$(TTT)="$(DESTDIR)$($(TTT))") -C $(WORKSRC) $(INSTALL_ARGS) user_install
	@$(MAKECOOKIE)
