GARNAME = python-pyminifier
GARVERSION = 1.3
CATEGORIES = python
MASTER_SITES = http://code.activestate.com/recipes/576704-python-code-minifier/download/1/
DISTFILES = pyminimizer.py
LICENSE = GPL3

DESCRIPTION = 
define BLURB
endef

DEPENDS = python/python

DISTNAME = $(GARNAME)

INSTALL_SCRIPTS = custom

include ../../gar.mk

extract-pyminimizer.py:
	@mkdir -p $(WORKSRC)
	@cp -f $(DOWNLOADDIR)/pyminimizer.py $(WORKSRC)/
	@$(MAKECOOKIE)

post-patch:
	@sed -i 's%^#!/usr/bin/env python%#!$(bindir)/python%' -i $(WORKSRC)/pyminimizer.py
	@$(MAKECOOKIE)

install-custom:
	@mkdir -p $(DESTDIR)$(bindir)
	@cp -r $(WORKSRC)/pyminimizer.py $(DESTDIR)$(bindir)/pyminimizer.py
	@chmod 755 $(DESTDIR)$(bindir)/pyminimizer.py
	@$(MAKECOOKIE)
