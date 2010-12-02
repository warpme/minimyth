GARNAME = myththemes-addons
GARVERSION = $(MYTHTV_VERSION)
CATEGORIES = $(CATEGORY)
SOURCEPKG = $(CATEGORY)/mythtv
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = \
	lang/cxx \
	$(CATEGORY)/mythtv

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

WORKSRC = $(WORKDIR)/mythtv-$(MYTHTV_VERSION)

#CONFIGURE_SCRIPTS = $(WORKSRC)/themes/configure
#INSTALL_SCRIPTS   = $(WORKSRC)/themes/Makefile

CONFIGURE_ARGS = \
	--prefix="$(prefix)" \
	--sysroot="$(DESTDIR)$(rootdir)" \
	--qmake="$(DESTDIR)$(qt4bindir)/qmake"

CONFIGURE_ENV = $(MYTHTV_CONFIGURE_ENV)
BUILD_ENV     = $(MYTHTV_BUILD_ENV)
INSTALL_ENV   = $(MYTHTV_INSTALL_ENV)

GAR_EXTRA_CONF += $(CATEGORY)/mythtv/package-api.mk
include ../../gar.mk

pre-configure:
	@echo "themes.files  ="                   >> $(WORKSRC)/themes/themes.pro
	@echo "themes.files += blootube-osd"      >> $(WORKSRC)/themes/themes.pro
	@echo "themes.files += blootubelite-wide" >> $(WORKSRC)/themes/themes.pro
	@echo "themes.files += Graphite"          >> $(WORKSRC)/themes/themes.pro

post-install: post-install-mythtv-version
	@$(MAKECOOKIE)
