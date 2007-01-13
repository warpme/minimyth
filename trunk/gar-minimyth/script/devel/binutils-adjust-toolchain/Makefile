GARNAME = binutils-adjust-toolchain
GARVERSION = $(BINUTILS_VERSION)
CATEGORIES = devel
LICENSE = GPL2/LGPL2

DESCRIPTION = 
define BLURB
endef

WORKSRC = $(WORKDIR)/binutils-$(GARVERSION)

DEPENDS = devel/binutils-bootstrap devel/glibc

#INSTALL_SCRIPTS = adjust-ld

GAR_EXTRA_CONF += devel/binutils/package-api.mk

include ../../gar.mk

xxx-install-adjust-ld:
	make -C ./../../devel/binutils-bootstrap/$(WORKSRC)/ld install
	$(MAKECOOKIE)
