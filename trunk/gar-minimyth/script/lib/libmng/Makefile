GARNAME = libmng
GARVERSION = 1.0.9
CATEGORIES = lib
MASTER_SITES = http://unc.dl.sourceforge.net/sourceforge/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = libmng
libmng_LICENSE_TEXT = $(WORKSRC)/LICENSE

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/libjpeg lib/zlib

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--with-gnu-ld \
	--with-zlib \
	--with-jpeg
	
include ../../gar.mk

pre-configure:
	@cp $(WORKSRC)/makefiles/configure.in $(WORKSRC)
	@cp $(WORKSRC)/makefiles/Makefile.am $(WORKSRC)
	@cd $(WORKSRC) ; aclocal
	@cd $(WORKSRC) ; libtoolize --automake
	@cd $(WORKSRC) ; automake --foreign --add-missing
	@cd $(WORKSRC) ; autoconf
	@$(MAKECOOKIE)

install-custom:
	@$(INSTALL_ENV) $(MAKE) DESTDIR=$(DESTDIR) $(foreach TTT,$(INSTALL_OVERRIDE_DIRS),$(TTT)="$(DESTDIR)$($(TTT))") -C $(WORKSRC) $(INSTALL_ARGS) install install-lib
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libmng.la
	@$(MAKECOOKIE)
