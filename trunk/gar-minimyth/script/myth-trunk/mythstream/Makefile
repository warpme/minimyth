GARNAME = mythstream
GARVERSION = 0.18_qt4
CATEGORIES = $(CATEGORY)
MASTER_SITES = http://home.kabelfoon.nl/~moongies/sw9vc4htz2/
DISTFILES = $(DISTNAME).tar.gz $(patsubst %,%.tar.gz,$(subst -,,$(PARSERS)))
PATCHFILES  =
PATCHFILES += \
	$(DISTNAME)-getthemedir.patch \
	$(DISTNAME)-qtopengl.patch \
	$(DISTNAME)-parser_youtube_fix.patch \
	$(DISTNAME)-fftw3f.patch \
	$(DISTNAME).patch.gar

PARSERS = \
	belegger \
	dailymotion-2 \
	google \
	retrovision \
	yahoo \
	youtube-3 \
	zoomin
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = \
	lang/c++ \
	$(CATEGORY)/mythtv \
	lib/fftw3f

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

WORKSRC = $(WORKDIR)/$(GARNAME)-0.18_qt4

CONFIGURE_SCRIPTS = $(WORKSRC)/mythtv
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ENV = $(MYTHTV_CONFIGURE_ENV)
BUILD_ENV     = $(MYTHTV_BUILD_ENV)
INSTALL_ENV   = $(MYTHTV_INSTALL_ENV)

GAR_EXTRA_CONF += $(CATEGORY)/myth/package-api.mk
include ../../gar.mk

post-extract:
	@$(foreach PARSER,$(PARSERS), \
		parser=$(word 1,$(subst -, ,$(PARSER))) ; \
		rm -rf $(WORKSRC)/parsers/$${parser} ; \
		mv -f $(WORKDIR)/$${parser} $(WORKSRC)/parsers/ ; )
	@$(MAKECOOKIE)

configure-%/mythtv:
	@cd $* ; $(CONFIGURE_ENV) $(DESTDIR)$(qt4bindir)/qmake QMAKE=$(DESTDIR)$(qt4bindir)/qmake $(GARNAME).pro
	@$(MAKECOOKIE)
