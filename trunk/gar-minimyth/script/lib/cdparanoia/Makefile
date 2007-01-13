GARNAME = cdparanoia
GARVERSION = III-alpha9.8
CATEGORIES = lib
MASTER_SITES = http://www.xiph.org/paranoia/download/
DISTFILES = $(DISTNAME).src.tgz
PATCHFILES = $(DISTNAME)-gcc-3.4.x.patch
LICENSE =

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --target=$(GARTARGET) \
	--x-includes=$(DESTDIR)$(x11includedir) \
	--x-libraries=$(DESTDIR)$(x11libdir) \
	--cache-file=config.cache
BUILD_ARGS     = \
	CPPFLAGS="$(CPPFLAGS)" \
	FLAGS="$(CFLAGS)" \
	OPT="$(CFLAGS)" \
	LDFLAGS="$(LDFLAGS)"

INSTALL_OVERRIDE_DIRS = prefix exec_prefix BINDIR MANDIR INCLUDEDIR LIBDIR

BINDIR     = $(bindir)
MANDIR     = $(mandir)
INCLUDEDIR = $(includedir)
LIBDIR     = $(libdir)

include ../../gar.mk

#GARBUILD  := $(shell echo $(GARBUILD)  | sed 's%-gnu$$%%')
#GARHOST   := $(shell echo $(GARHOST)   | sed 's%-gnu$$%%')
#GARTARGET := $(shell echo $(GARTARGET) | sed 's%-gnu$$%%')

pre-configure:
	@echo 'ac_cv_c_const=$${ac_cv_c_const=yes}'                 >> $(WORKSRC)/config.cache
	@echo 'ac_cv_header_stdc=$${ac_cv_header_stdc=yes}'         >> $(WORKSRC)/config.cache
	@echo 'ac_cv_sizeof_int=$${ac_cv_sizeof_int=4}'             >> $(WORKSRC)/config.cache
	@echo 'ac_cv_sizeof_long=$${ac_cv_sizeof_long=4}'           >> $(WORKSRC)/config.cache
	@echo 'ac_cv_sizeof_long_long=$${ac_cv_sizeof_long_long=8}' >> $(WORKSRC)/config.cache
	@echo 'ac_cv_sizeof_short=$${ac_cv_sizeof_short=2}'         >> $(WORKSRC)/config.cache
	@$(MAKECOOKIE)
