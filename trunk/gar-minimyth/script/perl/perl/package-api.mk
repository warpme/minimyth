PERL_VERSION = 5.8.8

PERL_PACKAGE_DEPENDS   = perl/perl
PERL_PACKAGE_BUILDDEPS = perl/perl

# This is a hack for cross compilation, but it should does not break native compilation.
# Ensure that everything is built using the compiler flags that were used when generating the config.sh files.
PERL_CPPFLAGS =
PERL_CFLAGS   = \
	$(strip \
		$(if $(filter i386  ,$(GARCH_FAMILY)),-pipe -O2 -mtune=generic -m32) \
		$(if $(filter x86_64,$(GARCH_FAMILY)),-pipe -O2 -mtune=generic -m64) \
	)
PERL_CXXFLAGS = \
	$(strip \
		$(if $(filter i386  ,$(GARCH_FAMILY)),-pipe -O2 -mtune=generic -m32) \
		$(if $(filter x86_64,$(GARCH_FAMILY)),-pipe -O2 -mtune=generic -m64) \
	)
PERL_LDFLAGS  = -Wl,--as-needed

PERL_libdir    = $(DESTDIR)$(libdir)/perl5
PERL_configdir = $(build_DESTDIR)$(build_libdir)/perl5/Config/$(PERL_VERSION)/$(GARCH_FAMILY)-linux-thread-multi

# This is a hack for cross compilation, but it should does not break native compilation.
# Ensure that packages being built have the highest chance of finding the installed packages.
# The the *.dynloader.patch file attempts to ensure that perl will look in these directories
# last when looking for *.so files, making less likely to break perl module execution.
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
