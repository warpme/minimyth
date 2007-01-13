GARNAME = libmng
GARVERSION = 1.0.8
CATEGORIES = lib
MASTER_SITES = http://unc.dl.sourceforge.net/sourceforge/libmng/
DISTFILES = $(GARNAME)-$(GARVERSION).tar.gz
LICENSE = libmng
libmng_LICENSE_TEXT = $(WORKSRC)/LICENSE

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/libjpeg lib/zlib

CONFIGURE_SCRIPTS = custom
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--with-zlib \
	--with-jpeg \
	--with-gnu-ld
	
xxx-BUILD_ARGS = \
	CC="$(CC)" \
	CFLAGS="$(CFLAGS)" \
	prefix="$(prefix)" \
	ZLIBINC="$(DESTDIR)$(includedir)" \
	ZLIBLIB="$(DESTDIR)$(libdir)" \
	JPEGINC="$(DESTDIR)$(includedir)" \
	JPEGLIB="$(DESTDIR)$(libdir)" \
	LCMSINC="$(DESTDIR)$(includedir)" \
	LCMSLIB="$(DESTDIR)$(libdir)"

xxx-INSTALL_OVERRIDE_DIRS = prefix exec_prefix

include ../../gar.mk

configure-custom:
	@cd $(WORKSRC) && $(CONFIGURE_ENV) sh autogen.sh $(CONFIGURE_ARGS)
	@$(MAKECOOKIE)

install-custom:
	@$(INSTALL_ENV) $(MAKE) DESTDIR=$(DESTDIR) $(foreach TTT,$(INSTALL_OVERRIDE_DIRS),$(TTT)="$(DESTDIR)$($(TTT))") -C $(WORKSRC) $(INSTALL_ARGS) install install-lib
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libmng.la
	@$(MAKECOOKIE)
