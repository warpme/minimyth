GARNAME = PerlSharp
GARVERSION =
CATEGORIES = perl
DISTFILES = PerlSharp.cgi
PATCHFILES = $(DISTNAME)-extensions.patch
LICENSE =

DESCRIPTION = 
define BLURB
endef

DEPENDS = perl/perl perl/perl-Perl-Tidy

DISTNAME = $(GARNAME)

INSTALL_SCRIPTS = custom

include ../../gar.mk

extract-PerlSharp.cgi:
	@mkdir -p $(WORKSRC)
	@cp -f $(DOWNLOADDIR)/PerlSharp.cgi $(WORKSRC)/
	@$(MAKECOOKIE)

post-patch:
	@sed -i 's%^#!/usr/bin/perl%#!$(bindir)/perl%' -i $(WORKSRC)/PerlSharp.cgi
	@$(MAKECOOKIE)

install-custom:
	@mkdir -p $(DESTDIR)$(bindir)
	@cp -r $(WORKSRC)/PerlSharp.cgi $(DESTDIR)$(bindir)/PerlSharp.cgi
	@chmod 755 $(DESTDIR)$(bindir)/PerlSharp.cgi
	@$(MAKECOOKIE)
