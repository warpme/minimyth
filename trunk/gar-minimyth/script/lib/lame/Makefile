GARNAME = lame
GARVERSION = 3.96.1
CATEGORIES = lib
MASTER_SITES = http://unc.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz config.cache.$(KERNEL_ARCH)
LICENSE = LGPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c lib/ncurses
BUILDDEPS = devel/nasm

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--cache-file=config.cache \
	--enable-nasm \
	--with-gnu-ld

GAR_EXTRA_CONF += kernel/linux/package-api.mk
include ../../gar.mk

extract-config.cache.$(KERNEL_ARCH):
	@cp $(DOWNLOADDIR)/config.cache.$(KERNEL_ARCH) $(WORKSRC)/config.cache
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libmp3lame.la
	@$(MAKECOOKIE)
