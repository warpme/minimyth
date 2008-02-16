GARNAME = perl
GARVERSION = 5.8.8
CATEGORIES = perl
MASTER_SITES = http://www.cpan.org/src/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES  =
ifneq ($(DESTIMG),build)
PATCHFILES += $(DISTNAME)-config_sh-$(GARCH_FAMILY).patch.gar $(DISTNAME)-cross.patch.gar
endif
LICENSE = 

DESCRIPTION = 
define BLURB
endef

PWD = `pwd`

DEPENDS    = lang/c
BUILDDEPS  =
ifneq ($(DESTIMG),build)
BUILDDEPS += perl/perl
endif

CONFIGURE_SCRIPTS  = $(WORKSRC)/configure
BUILD_SCRIPTS      = $(WORKSRC)/makefile
INSTALL_SCRIPTS    = $(WORKSRC)/makefile miniperl

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

include ../../gar.mk

CFLAGS   := $(filter-out -O% -march=%,$(CFLAGS))   -O2 -mtune=generic
CXXFLAGS := $(filter-out -O% -march=%,$(CXXFLAGS)) -O2 -mtune=generic

PERL_libpth = `$(CC) -print-search-dirs \
	| grep '^libraries' \
	| sed -e 's%^libraries: *%%' -e 's%:% %g' -e 's%=%%g' -e 's%//*%/%g' -e 's%/ % %g' -e 's%/$$%%' \
	| sed -e 's%[^ ]*$(GARHOST)[^ ]*%%g' \
	`
PERL_build_archlib = $(build_DESTDIR)$(build_libdir)/perl5/$(GARVERSION)/$(build_GARCH_FAMILY)-linux-thread-multi

pre-configure:
	@ln -sf Configure $(WORKSRC)/configure
	@$(MAKECOOKIE)

post-configure:
	@$(BUILD_ENV) $(MAKE) $(PARALLELMFLAGS) $(foreach TTT,$(BUILD_OVERRIDE_DIRS),$(TTT)="$($(TTT))") -C $(WORKSRC) $(BUILD_ARGS) depend
	@for file in `find $(WORKSRC) -name makefile` ; do \
		sed -i 's%^[^:]*: *<command-line>$$%%' $${file} ; \
	 done
	@$(MAKECOOKIE)

pre-install:
	@mkdir -p $(PERL_build_archlib)
	@cp -f $(WORKSRC)/lib/Config.pm       $(PERL_build_archlib)/Config-$(GARHOST).pm
	@cp -f $(WORKSRC)/lib/Config.pod      $(PERL_build_archlib)/Config-$(GARHOST).pod
	@cp -f $(WORKSRC)/lib/Config_heavy.pl $(PERL_build_archlib)/Config_heavy-$(GARHOST).pl
	@ln -sf Config-$(GARHOST).pm          $(PERL_build_archlib)/Config.pm
	@ln -sf Config-$(GARHOST).pod         $(PERL_build_archlib)/Config.pod
	@ln -sf Config_heavy-$(GARHOST).pl    $(PERL_build_archlib)/Config_heavy.pl
	@$(MAKECOOKIE)

install-miniperl:
	@mkdir -p $(DESTDIR)$(bindir)
	@cp -f $(WORKSRC)/miniperl $(DESTDIR)$(bindir)/perl-miniperl
	@$(MAKECOOKIE)

post-install:
	@rm -f $(PERL_build_archlib)/Config.pm
	@rm -f $(PERL_build_archlib)/Config.pod
	@rm -f $(PERL_build_archlib)/Config_heavy.pl
	@$(MAKECOOKIE)
