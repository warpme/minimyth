GARNAME = busybox
GARVERSION = 1.10.2
CATEGORIES = utils
MASTER_SITES  = http://www.busybox.net/downloads/
MASTER_SITES += http://www.busybox.net/downloads/fixes-$(GARVERSION)/
CONFIGFILE = $(DISTNAME).config
DISTFILES = $(DISTNAME).tar.bz2 $(CONFIGFILE)
PATCHFILES  = \
	$(DISTNAME)-mdev.patch
PATCHFILES += $(DISTNAME)-dhcp_options.patch $(DISTNAME)-dhcp_timezone.patch $(DISTNAME)-tftp_timeout.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = custom
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = custom

DEFAULT_ARGS = \
	ARCH="$(GARCH_FAMILY)" \
	HOSTCC="$(build_CC)" \
	HOSTCXX="$(build_CXX)" \
	HOSTCFLAGS="$(build_CFLAGS)" \
	HOSTCXXFLAGS="$(build_CXXFLAGS)" \
	CROSS_COMPILE="$(compiler_prefix)" \
	KBUILD_VERBOSE="1"

CONFIGURE_ARGS = $(DEFAULT_ARGS)
BUILD_ARGS     = $(DEFAULT_ARGS)
INSTALL_ARGS   = $(DEFAULT_ARGS)

include ../../gar.mk

extract-$(CONFIGFILE):
	@cat $(DOWNLOADDIR)/$(CONFIGFILE) \
		| sed -e 's%@GAR_rootdir@%$(rootdir)%g' \
		| sed -e 's%@GAR_localstatedir@%$(localstatedir)%g' \
		> $(WORKDIR)/$(CONFIGFILE)
	@$(MAKECOOKIE)

pre-configure:
	@rm -rf   $(WORKSRC)/arch/$(GARCH_FAMILY)
	@mkdir -p $(WORKSRC)/arch/$(GARCH_FAMILY)
	@echo "CPPFLAGS += $(CPPFLAGS)" >> $(WORKSRC)/arch/$(GARCH_FAMILY)/Makefile
	@echo "CFLAGS   += $(CFLAGS)"   >> $(WORKSRC)/arch/$(GARCH_FAMILY)/Makefile
	@$(MAKECOOKIE)

configure-custom:
	@$(CONFIGURE_ENV) $(MAKE) $(CONFIGURE_ARGS) -C $(WORKSRC) mrproper
	@cp $(WORKDIR)/$(CONFIGFILE) $(WORKSRC)/.config
	@$(CONFIGURE_ENV) $(MAKE) $(CONFIGURE_ARGS) -C $(WORKSRC) oldconfig
	@$(CONFIGURE_ENV) $(MAKE) $(CONFIGURE_ARGS) -C $(WORKSRC) clean
	@$(MAKECOOKIE)

install-custom:
	@$(INSTALL_ENV) $(MAKE) $(INSTALL_ARGS) -C $(WORKSRC) CONFIG_PREFIX="$(DESTDIR)$(rootdir)" install
