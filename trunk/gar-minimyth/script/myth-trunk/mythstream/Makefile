GARNAME = mythstream
GARVERSION = 0.18_qt4
CATEGORIES = $(CATEGORY)
MASTER_SITES = http://home.kabelfoon.nl/~moongies/sw9vc4htz2/
DISTFILES = $(DISTNAME).tar.gz $(subst -,,$(PARSERS))
PATCHFILES  =
PATCHFILES += \
	$(DISTNAME)-gcc_warnings_fixes.patch \
	$(DISTNAME)-streams_res.patch \
	$(DISTNAME)-qt_paintevent_fix.patch \
	$(DISTNAME)-qt_bitblt_replace.patch \
	$(DISTNAME)-user_agent_quicktime.patch \
	$(DISTNAME)-youtube_parser_fix.patch \
	$(DISTNAME)-mythtv_0_22.patch \
	$(DISTNAME)-fftw3f.patch \
	$(DISTNAME).patch.gar
PARSERS = \
	apple-3.pl \
	belegger.tar.gz \
	dailymotion-2.tar.gz \
	google.tar.gz \
	omroep-3.tar.gz \
	retrovision.tar.gz \
	shoutcast-2.tar.gz \
	yahoo.tar.gz \
	youtube-5.tar.gz \
	zoomin.tar.gz
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
		parser_ext=$(patsubst %.pl,pl,$(patsubst %.tar.gz,gar.gz,$(PARSER))) ; \
		if   [ "$${parser_ext}" = "pl" ] ; then \
			parser_src=$(word 1,$(subst -,,$(patsubst %.pl,%,$(PARSER)))) ; \
			parser_dst=$(word 1,$(subst -, ,$(patsubst %.pl,%,$(PARSER)))) ; \
			parser_src="$${parser_src}.pl" ; \
			parser_dst="$${parser_dst}.pl" ; \
			rm -rf $(WORKSRC)/parsers/$${parser_dst} ; \
			mv -f $(WORKDIR)/$${parser_src} $(WORKSRC)/parsers/$${parser_dst} ; \
		elif [ "$${parser_ext}" = "gar.gz" ] ; then \
			parser_src=$(word 1,$(subst -, ,$(patsubst %.tar.gz,%,$(PARSER)))) ; \
			parser_dst=$(word 1,$(subst -, ,$(patsubst %.tar.gz,%,$(PARSER)))) ; \
			rm -rf $(WORKSRC)/parsers/$${parser_dst} ; \
			mv -f $(WORKDIR)/$${parser_src} $(WORKSRC)/parsers/$${parser_dst} ; \
                	for file in `cd $(WORKSRC)/parsers/$${parser_dst} ; ls -1` ; do \
				if [ -e $(WORKSRC)/parsers/$${file} ] ; then \
					rm -f $(WORKSRC)/parsers/$${file} ; \
					cp -pd $(WORKSRC)/parsers/$${parser_dst}/$${file} $(WORKSRC)/parsers/$${file} ; \
				fi ; \
                	done ; \
		fi ; )
	@# Remove parsers that are actually bash scripts not perl scripts.
	@rm -fr $(WORKSRC)/parsers/belegger
	@rm -fr $(WORKSRC)/parsers/zoomin
	@$(MAKECOOKIE)

configure-%/mythtv:
	@cd $* ; $(CONFIGURE_ENV) $(DESTDIR)$(qt4bindir)/qmake QMAKE=$(DESTDIR)$(qt4bindir)/qmake $(GARNAME).pro
	@$(MAKECOOKIE)
