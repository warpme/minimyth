GARNAME = devfsd
GARVERSION = v1.3.25
CATEGORIES = system
MASTER_SITES = ftp://ftp.atnf.csiro.au/pub/people/rgooch/linux/daemons/$(GARNAME)/
DISTFILES = $(GARNAME)-$(GARVERSION).tar.gz
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c kernel/linux

WORKSRC = $(WORKDIR)/$(GARNAME)

BUILD_SCRIPTS   = $(WORKSRC)/GNUmakefile
INSTALL_SCRIPTS = $(WORKSRC)/GNUmakefile

BUILD_ARGS = KERNEL_DIR="$(DESTDIR)$(KERNEL_BUILDDIR)"

BUILD_OVERRIDE_DIRS   = PREFIX SBINDIR MANDIR CONFDIR
INSTALL_OVERRIDE_DIRS = PREFIX SBINDIR MANDIR CONFDIR

GAR_EXTRA_CONF += kernel/linux/package-api.mk
include ../../gar.mk

PREFIX  := $(prefix)
SBINDIR := $(esbindir)
MANDIR  := $(mandir)
CONFDIR := $(sysconfdir)

post-patch:
	@sed -i 's%/lib/libnsl\.so\.%$(DESTDIR)$(elibdir)/libnsl.so.%g' $(WORKSRC)/GNUmakefile
	@$(MAKECOOKIE)
