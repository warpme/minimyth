GARNAME = webfs
GARVERSION = 1.21
CATEGORIES = net
MASTER_SITES = http://dl.bytesex.org/releases/webfs/
DISTFILES = $(GARNAME)-$(GARVERSION).tar.gz Make.config
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

BUILD_SCRIPTS   = $(WORKSRC)/GNUmakefile
INSTALL_SCRIPTS = $(WORKSRC)/GNUmakefile

BUILD_ARGS = verbose=yes

extract-Make.config:
	@cp $(DOWNLOADDIR)/Make.config $(WORKSRC)
	@$(MAKECOOKIE)

include ../../gar.mk
