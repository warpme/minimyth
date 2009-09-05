GARNAME = Python
GARVERSION =  2.6.2
CATEGORIES = python
MASTER_SITES = http://www.python.org/ftp/python/$(GARVERSION)/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE =

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c
BUILDDEPS =

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--enable-shared
	
include ../../gar.mk

post-install:
	@rm -f $(DESTDIR)$(libdir)/python2.6/config/libpython2.6.a
	@$(MAKECOOKIE)
