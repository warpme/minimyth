GARNAME = perl
GARVERSION = $(PERL_VERSION)
CATEGORIES = $(CATEGORY)
MASTER_SITES = http://www.cpan.org/src/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES  = $(DISTNAME)-perl5lib.patch
ifneq ($(DESTIMG),build)
PATCHFILES += $(DISTNAME)-config_sh-$(GARCH_FAMILY).patch.gar $(DISTNAME)-cross.patch.gar
else
PATCHFILES += $(DISTNAME)-errno.patch
endif
LICENSE = 

DESCRIPTION = 
define BLURB
endef

CATEGORY := $(shell basename $(shell dirname $(shell pwd)))

DEPENDS    = lang/c
BUILDDEPS  =
ifneq ($(DESTIMG),build)
BUILDDEPS += $(CATEGORY)/$(GARNAME)
endif

CONFIGURE_SCRIPTS  = $(WORKSRC)/configure
BUILD_SCRIPTS      = $(WORKSRC)/makefile
INSTALL_SCRIPTS    = config miniperl $(WORKSRC)/makefile

ifneq ($(DESTIMG),build)
CONFIGURE_ARGS = \
	-e \
	-S
else
CONFIGURE_ARGS = \
	-d \
	-e \
	-Dprefix="$(prefix)" \
	-Dman1dir='$(mandir)/man1' \
	-Dman3dir='$(mandir)/man3' \
	-Dpager='/bin/less -isR' \
	-Darchname="$(GARCH_FAMILY)-linux" \
	-Dusrinc="$(DESTDIR)$(includedir)" \
	-Dlibpth="$(PERL_libpth)" \
	-Dglibpth="$(PERL_libpth)" \
	-Dcpp="$(CPP)" \
	-Dcc="$(CC)" \
	-Dld="$(CC)" \
	-Dar="$(AR)" \
	-Dnm="$(NM)" \
	-Dranlib="$(RANLIB)" \
	-Dccflags="$(CFLAGS)" \
	-Dldflags="$(LDFLAGS)" \
	-Dusethreads \
	-Adefine:cf_by=' ' \
	-Adefine:cf_email=' ' \
	-Adefine:locincpth=' ' \
	-Adefine:loclibpth=' ' \
	-Adefine:mydomain=' ' \
	-Adefine:myhostname=' ' \
	-Adefine:myuname=' ' \
	-Adefine:optimize=' '
endif

CONFIGURE_ENV = $(PERL_PACKAGE_DEFAULT_ENV)
BUILD_ENV     = $(PERL_PACKAGE_DEFAULT_ENV)
INSTALL_ENV   = $(PERL_PACKAGE_DEFAULT_ENV)

include ../../gar.mk

CFLAGS   := $(filter-out -O% -march=%,$(CFLAGS))   -O2 -mtune=generic
CXXFLAGS := $(filter-out -O% -march=%,$(CXXFLAGS)) -O2 -mtune=generic

PERL_libpth := `$(CC) -print-search-dirs \
	| grep '^libraries' \
	| sed -e 's%^libraries: *%%' -e 's%:% %g' -e 's%=%%g' -e 's%//*%/%g' -e 's%/ % %g' -e 's%/$$%%' \
	| sed -e 's%[^ ]*$(GARHOST)[^ ]*%%g'`

pre-configure:
	@ln -sf Configure $(WORKSRC)/configure
	@$(MAKECOOKIE)

post-configure:
	@$(BUILD_ENV) $(MAKE) $(PARALLELMFLAGS) $(foreach TTT,$(BUILD_OVERRIDE_DIRS),$(TTT)="$($(TTT))") -C $(WORKSRC) $(BUILD_ARGS) depend
	@for file in `find $(WORKSRC) -name makefile` ; do \
		sed -i 's%^[^:]*: *<command-line>$$%%' $${file} ; \
	 done
	@$(MAKECOOKIE)

install-config:
	@mkdir -p $(PERL_configdir)
	@cp -f $(WORKSRC)/lib/Config.pm       $(PERL_configdir)
	@cp -f $(WORKSRC)/lib/Config.pod      $(PERL_configdir)
	@cp -f $(WORKSRC)/lib/Config_heavy.pl $(PERL_configdir)
	@$(MAKECOOKIE)

install-miniperl:
	@mkdir -p $(DESTDIR)$(bindir)
	@cp -f $(WORKSRC)/miniperl $(DESTDIR)$(bindir)/perl-miniperl
	@$(MAKECOOKIE)

