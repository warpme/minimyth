GARNAME = libdaemon
GARVERSION = 0.12
CATEGORIES = net
MASTER_SITES = http://0pointer.de/lennart/projects/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = LGPL2_1

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS  = $(WORKSRC)/configure
BUILD_SCRIPTS      = $(WORKSRC)/Makefile
INSTALL_SCRIPTS    = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-lynx \
	--with-gnu-ld

CONFIGURE_ENV = \
	ac_cv_func_fork_works=yes \
	ac_cv_func_setpgrp_void=yes

include ../../gar.mk

post-install:
	@rm -f $(DESTDIR)$(libdir)/libdaemon.la
	@sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'         $(DESTDIR)$(libdir)/pkgconfig/libdaemon.pc
	@sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g' $(DESTDIR)$(libdir)/pkgconfig/libdaemon.pc
	@$(MAKECOOKIE)
