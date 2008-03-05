GARNAME = upstart
GARVERSION = 0.3.9
CATEGORIES = system
MASTER_SITES = http://upstart.ubuntu.com/download/0.3/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-limits_h.patch
LICENSE = GPL2

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-threads=posix \
	--disable-rpath \
	--enable-compat \
	--with-gnu-ld

include ../../gar.mk

exec_prefix := $(rootdir)
bindir      := $(ebindir)
sbindir     := $(esbindir)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libupstart.la
	@rm -f $(DESTDIR)$(libdir)/libnih.la
	@$(MAKECOOKIE)
