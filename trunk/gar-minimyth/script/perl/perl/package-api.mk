PERL_VERSION = 5.8.8

PERL_PACKAGE_DEPENDS   = perl/perl
PERL_PACKAGE_BUILDDEPS = perl/perl

PERL_CFLAGS   = $(filter-out -O% -march=%,$(CFLAGS))   -O2 -mtune=generic
PERL_CXXFLAGS = $(filter-out -O% -march=%,$(CXXFLAGS)) -O2 -mtune=generic

PERL_libdir    = $(DESTDIR)$(libdir)/perl5
PERL_configdir = $(build_DESTDIR)$(build_libdir)/perl5/Config/$(PERL_VERSION)/$(GARCH_FAMILY)-linux-thread-multi

PERL5LIB = \
	$(patsubst %:,%,$(subst : ,:,$(patsubst %,%:,\
		$(PERL_configdir) \
		$(PERL_libdir)/site_perl/$(PERL_VERSION)/$(GARCH_FAMILY)-linux-thread-multi \
		$(PERL_libdir)/site_perl/$(PERL_VERSION) \
		$(PERL_libdir)/site_perl/ \
	)))

PERL_PACKAGE_DEFAULT_ARGS = \
	DESTDIR="$(DESTDIR)"

PERL_PACKAGE_DEFAULT_ENV  = \
	PERL5LIB="$(PERL5LIB)"

configure-perl-package:
	@cd $(WORKSRC) ; $(CONFIGURE_ENV) perl Makefile.PL $(CONFIGURE_ARGS)
	@for file in `find $(WORKSRC) -name Makefile` ; do \
		sed -i 's%^PERL_INC *= *%PERL_INC = $$(DESTDIR)%' $${file} ; \
		sed -i 's%^PERL_ARCHLIB *= *%PERL_ARCHLIB = $$(DESTDIR)%' $${file} ; \
	 done
	@$(MAKECOOKIE)
