GARNAME        = perl-DBD-mysql
GARVERSION     = 4.011
MASTER_SITES   = http://www.cpan.org/authors/id/C/CA/CAPTTOFU/
DEPENDS        = perl/perl-DBI
PERL_MODULE_SO = true

include ../../perl/perl/perl-module.mk

CONFIGURE_ARGS += \
	--mysql_config=$(DESTDIR)$(bindir)/mysql_config
