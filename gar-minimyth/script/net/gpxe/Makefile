GARNAME = gpxe
GARVERSION = 0.9.3
CATEGORIES = net
MASTER_SITES = http://kernel.org/pub/software/utils/boot/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS   = lang/c

BUILD_SCRIPTS   = $(WORKSRC)/src/Makefile
INSTALL_SCRIPTS = custom

BUILD_ARGS = \
	HOST_CC="$(build_CC)" \
	PERL="$(build_DESTDIR)$(build_bindir)/perl" \
	CROSS_COMPILE="$(compiler_prefix)" \
	ARCH="$(GARCH_FAMILY)" \
	Q=" " \
	bin/undionly.kpxe

include ../../gar.mk

CPPFLAGS :=
CFLAGS   :=
CXXFLAGS :=
LDFLAGS  :=

install-custom:
	@mkdir -p $(DESTDIR)$(rootdir)/srv/tftpboot/minimyth
	@cp -f $(WORKSRC)/src/bin/undionly.kpxe $(DESTDIR)$(rootdir)/srv/tftpboot/minimyth/gpxe.0
	@mkdir -p $(DESTDIR)$(rootdir)/srv/tftpboot/minimyth/gpxe.cfg
	@$(MAKECOOKIE)
