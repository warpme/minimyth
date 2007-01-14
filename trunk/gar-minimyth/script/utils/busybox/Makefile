GARNAME = busybox
GARVERSION = 1.2.2
CATEGORIES = utils
MASTER_SITES = http://www.busybox.net/downloads/
CONFIGFILE = $(DISTNAME).config
DISTFILES = $(DISTNAME).tar.bz2 $(CONFIGFILE)
PATCHFILES = $(DISTNAME)-dhcp_options.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

#DEPENDS = lang/c

CONFIGURE_SCRIPTS = custom
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = custom

CONFIGURE_ARGS = \
	TARGET_ARCH="$(GARCH_FAMILY)" \
	oldconfig
BUILD_ARGS = \
	TARGET_ARCH="$(GARCH_FAMILY)" \
	CC="$(CC)" \
	AR="$(AR)" \
	AS="$(AS)" \
	LD="$(LD)" \
	NM="$(NM)" \
	STRIP="$(STRIP)" \
	CPP="$(CPP)" \
	OPTIMIZATIONS="$(CFLAGS)" \
	LDFLAGS="$(LDFLAGS)" \
	HOSTCC="$(build_CC)" \
	HOSTCFLAGS="$(build_CFLAGS)"
INSTALL_ARGS =
BUILD_OVERRIDE_DIRS = PREFIX
INSTALL_OVERRIDE_DIRS = PREFIX

PREFIX=$(prefix)

ifeq ($(DESTIMG),build)
USING_CROSS_COMPILER = n
else
USING_CROSS_COMPILER = y
endif

include ../../gar.mk

extract-$(CONFIGFILE):
	@cat $(DOWNLOADDIR)/$(CONFIGFILE) \
		| sed -e 's%@USING_CROSS_COMPILER@%$(USING_CROSS_COMPILER)%g' \
		| sed -e 's%@GAR_rootdir@%$(rootdir)%g' \
		> $(WORKSRC)/.config
	@$(MAKECOOKIE)

configure-custom:
	@$(CONFIGURE_ENV) $(MAKE) -C $(WORKSRC) $(CONFIGURE_ARGS)
	@$(MAKECOOKIE)

install-custom:
	@$(INSTALL_ENV) $(MAKE) -C $(WORKSRC) PREFIX=$(DESTDIR)$(rootdir) install
