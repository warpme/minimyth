GARNAME = irserver
GARVERSION = 29.10.07
CATEGORIES = system
# This site lacks a version number so we will download it from linprv.org.
#MASTER_SITES = http://www.irtrans.de/download/Server/Linux/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = BSD_3_Clause

DESCRIPTION =
define BLURB
endef

DEPENDS = lang/c

BUILD_SCRIPTS   = $(WORKSRC)/makefile
INSTALL_SCRIPTS = custom

BUILD_ARGS = \
	SHELL="sh" \
	CC="$(CC)" \
	CFLAGS="$(CFLAGS)" \
	CPPFLAGS="$(CPPFLAGS) -DLINUX -Icommon" \
	LDFLAGS="$(LDFLAGS)" \
	$(if $(filter i386,$(GARCH_FAMILY)),irserver) \
	$(if $(filter x86_64,$(GARCH_FAMILY)),irserver64)

include ../../gar.mk

install-custom:
	@mkdir -p $(DESTDIR)$(sbindir)
	@rm -rf $(DESTDIR)$(sbindir)/irserver
	@cp $(WORKSRC)/irserver $(DESTDIR)$(sbindir)
	@mkdir -p $(DESTDIR)$(datadir)/irtrans
	@rm -rf $(DESTDIR)$(datadir)/irtrans/remotes
	@cp -r $(WORKSRC)/remotes  $(DESTDIR)$(datadir)/irtrans
	@$(MAKECOOKIE)
