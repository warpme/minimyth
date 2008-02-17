GARNAME = XML-LibXML
GARVERSION = 1.66
CATEGORIES = perl
MASTER_SITES = http://www.cpan.org/authors/id/P/PA/PAJAS/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-disable_have_library.patch
LICENSE = Artistic

DESCRIPTION = 
define BLURB
endef

DEPENDS    = $(PERL_PACKAGE_DEPENDS)   lib/libxml2 perl/perl-XML-LibXML-Common perl/perl-XML-NamespaceSupport perl/perl-XML-SAX
BUILDDEPS  = $(PERL_PACKAGE_BUILDDEPS)             perl/perl-XML-LibXML-Common
ifneq ($(DESTIMG),build)
BUILDDEPS += perl/perl-XML-LibXML
endif

CONFIGURE_SCRIPTS = perl-package
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS =
BUILD_ARGS     = $(PERL_PACKAGE_DEFAULT_ARGS)
INSTALL_ARGS   = $(PERL_PACKAGE_DEFAULT_ARGS)

CONFIGURE_ENV = $(PERL_PACKAGE_DEFAULT_ENV) \
	XMLPREFIX="$(DESTDIR)$(prefix)"
BUILD_ENV     = $(PERL_PACKAGE_DEFAULT_ENV)
INSTALL_ENV   = $(PERL_PACKAGE_DEFAULT_ENV)

GAR_EXTRA_CONF += perl/perl/package-api.mk
include ../../gar.mk

CFLAGS   := $(PERL_CFLAGS)
CXXFLAGS := $(PERL_CXXFLAGS)
