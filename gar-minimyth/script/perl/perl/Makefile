GARNAME = perl
GARVERSION = 5.8.8
CATEGORIES = perl
MASTER_SITES = http://www.cpan.org/src/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES  =
PATCHFILES += \
	$(if $(filter-out $(build_GARCH_FAMILY),$(GARCH_FAMILY)), \
		$(DISTNAME)-config_sh-$(GARCH_FAMILY).patch.gar \
		$(DISTNAME)-cross.patch.gar \
	)
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

CONFIGURE_ARGS = $(PERL_CONFIGURE_ARGS)

GAR_EXTRA_CONF += perl/perl/package-api.mk
include ../../gar.mk

CFLAGS   := $(filter-out -O% -march=%,$(CFLAGS))   -O2 -mtune=generic
CXXFLAGS := $(filter-out -O% -march=%,$(CXXFLAGS)) -O2 -mtune=generic

build_PERLLIB = $(build_DESTDIR)$(build_libdir)/perl5/$(GARVERSION)/$(build_GARCH_FAMILY)-linux-thread-multi/

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
	@mkdir -p $(build_PERLLIB)
	@cp -f $(WORKSRC)/lib/Config.pm       $(build_PERLLIB)/Config-$(GARHOST).pm
	@cp -f $(WORKSRC)/lib/Config.pod      $(build_PERLLIB)/Config-$(GARHOST).pod
	@cp -f $(WORKSRC)/lib/Config_heavy.pl $(build_PERLLIB)/Config_heavy-$(GARHOST).pl
	@ln -sf Config-$(GARHOST).pm          $(build_PERLLIB)/Config.pm
	@ln -sf Config-$(GARHOST).pod         $(build_PERLLIB)/Config.pod
	@ln -sf Config_heavy-$(GARHOST).pl    $(build_PERLLIB)/Config_heavy.pl
	@$(MAKECOOKIE)

install-miniperl:
	@mkdir -p $(DESTDIR)$(bindir)
	@cp -f $(WORKSRC)/miniperl $(DESTDIR)$(bindir)/perl-miniperl
	@$(MAKECOOKIE)

post-install:
	@rm -f $(build_PERLLIB)/Config.pm
	@rm -f $(build_PERLLIB)/Config.pod
	@rm -f $(build_PERLLIB)/Config_heavy.pl
	@$(MAKECOOKIE)
