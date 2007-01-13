GARNAME = lsdvd
GARVERSION = 0.15
CATEGORIES = utils
MASTER_SITES = http://easynews.dl.sourceforge.net/sourceforge/acidrip/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-cflags.patch
LICENSE =

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c lib/libdvdread

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--cache-file=config.cache

include ../../gar.mk

CFLAGS := $(CFLAGS) -ldl

pre-configure:
	@cd $(WORKSRC); aclocal
	@cd $(WORKSRC); libtoolize --copy --force
	@cd $(WORKSRC); autoconf
	@cd $(WORKSRC); autoheader
	@cd $(WORKSRC); automake --copy --add-missing
	@cd $(WORKSRC); cp $(build_DESTDIR)$(build_datadir)/libtool/install-sh .
	@rm -rf $(WORKSRC)/config.cache
	@echo "ac_cv_lib_dvdread_DVDOpen=yes" >> $(WORKSRC)/config.cache
	@$(MAKECOOKIE)
