PERL_VERSION = 5.8.8

PERL_CONFIGURE_ENV = PERL5LIB="$(PERL5LIB)"
PERL_BUILD_ENV     = PERL5LIB="$(PERL5LIB)"
PERL_INSTALL_ENV   = PERL5LIB="$(PERL5LIB)"

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
# last when looking for *.so files, making it less likely to break perl module execution.
PERL5LIB = \
	$(patsubst %:,%,$(subst : ,:,$(patsubst %,%:,\
		$(PERL_configdir) \
		$(PERL_libdir)/site_perl/$(PERL_VERSION)/$(GARCH_FAMILY)-linux-thread-multi \
		$(PERL_libdir)/site_perl/$(PERL_VERSION) \
		$(PERL_libdir)/site_perl/ \
	)))
