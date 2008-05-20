GARNAME = irserver
GARVERSION = 29.10.07
CATEGORIES = system
# This site lacks a version number so we will download it from linprv.org.
#MASTER_SITES = http://www.irtrans.de/download/Server/Linux/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-gcc_4.3.patch
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
	irclient \
	$(if $(filter i386,$(GARCH_FAMILY)),irserver) \
	$(if $(filter x86_64,$(GARCH_FAMILY)),irserver64)

include ../../gar.mk

install-custom:
	@mkdir -p $(DESTDIR)$(sbindir)
	@rm -rf $(DESTDIR)$(sbindir)/irclient
	cp $(WORKSRC)/irclient $(DESTDIR)$(sbindir)/irclient
	@rm -rf $(DESTDIR)$(sbindir)/irserver
	@$(if $(filter i386,  $(GARCH_FAMILY)),cp $(WORKSRC)/irserver   $(DESTDIR)$(sbindir)/irserver)
	@$(if $(filter x86_64,$(GARCH_FAMILY)),cp $(WORKSRC)/irserver64 $(DESTDIR)$(sbindir)/irserver)
	@mkdir -p $(DESTDIR)$(datadir)/irtrans
	@rm -rf $(DESTDIR)$(datadir)/irtrans/remotes
	@cp -r $(WORKSRC)/remotes $(DESTDIR)$(datadir)/irtrans
	@$(MAKECOOKIE)
