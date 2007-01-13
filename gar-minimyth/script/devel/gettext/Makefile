GARNAME = gettext
GARVERSION = 0.14.4
CATEGORIES = devel
MASTER_SITES = ftp://ftp.gnu.org/gnu/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c lib/expat

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--with-gnu-ld

include ../../gar.mk

post-install:
	@rm -f $(DESTDIR)$(libdir)/libasprintf.la
	@rm -f $(DESTDIR)$(libdir)/libgettextlib.la
	@rm -f $(DESTDIR)$(libdir)/libgettextsrc.la
	@rm -f $(DESTDIR)$(libdir)/libgettextpo.la
	@$(MAKECOOKIE)
