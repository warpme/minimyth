################################################################################
# PERL_MODULE_PATCHES:
#    - Lists the patch file names with the $(DISTNAME) prefix removed.
# PERL_MODULE_STYLE:
#    - Indicates the module's installation style.
#    - Valid values: 'Makefile.PL' and 'Build.PL' with 'Makefile.PL' being the default.
# PERL_MODULE_SO:
#    - Indicates whether or not the installed module contains a shared object.
#    - Valid values: 'true' or 'false' with 'false' being the default.
################################################################################

PERL_MODULE_STYLE ?= Makefile.PL
PERL_MODULE_SO    ?= false

CATEGORIES = perl
DISTFILES = $(PERL_MODULE_DISTNAME).tar.gz
PATCHFILES = $(addprefix $(PERL_MODULE_DISTNAME)-,$(PERL_MODULE_PATCHES))

PERL_MODULE_GARNAME = $(patsubst perl-%,%,$(GARNAME))
PERL_MODULE_DISTNAME = $(PERL_MODULE_GARNAME)-$(GARVERSION)

WORKSRC = $(WORKDIR)/$(PERL_MODULE_DISTNAME)

DEPENDS   += perl/perl lang/c
BUILDDEPS += perl/perl
# When cross compiling a module that includes a shared object, we build the
# native version of the module so that a working shared object can be found when
# testing for dependent modules.
ifneq ($(DESTIMG),build)
ifneq ($(PERL_MODULE_SO),false)
BUILDDEPS += perl/$(GARNAME)
endif
endif

ifeq ($(PERL_MODULE_STYLE),Makefile.PL)
CONFIGURE_SCRIPTS = $(WORKSRC)/Makefile.PL
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS =
BUILD_ARGS     = DESTDIR="$(DESTDIR)"
INSTALL_ARGS   = DESTDIR="$(DESTDIR)"

CONFIGURE_ENV = PERL5LIB="$(PERL5LIB)"
BUILD_ENV     = PERL5LIB="$(PERL5LIB)"
INSTALL_ENV   = PERL5LIB="$(PERL5LIB)"
endif

ifeq ($(PERL_MODULE_STYLE),Build.PL)
CONFIGURE_SCRIPTS = $(WORKSRC)/Build.PL
BUILD_SCRIPTS     = $(WORKSRC)/Build
INSTALL_SCRIPTS   = $(WORKSRC)/Build

CONFIGURE_ARGS =
BUILD_ARGS     =
INSTALL_ARGS   =

CONFIGURE_ENV = PERL5LIB="$(PERL5LIB)"
BUILD_ENV     = PERL5LIB="$(PERL5LIB)"
INSTALL_ENV   = PERL5LIB="$(PERL5LIB)" PERL_INSTALL_ROOT="$(DESTDIR)"
endif

include ../../perl/perl/package-api.mk
include ../../gar.mk

CPPFLAGS := $(PERL_CPPFLAGS)
CFLAGS   := $(PERL_CFLAGS)
CXXFLAGS := $(PERL_CXXFLAGS)
LDFLAGS  := $(PERL_LDFLAGS)
