GARNAME = coreutils
GARVERSION = 6.5
CATEGORIES = utils
MASTER_SITES = ftp://ftp.gnu.org/gnu/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.bz2
PATCHFILES = $(DISTNAME)-sysinfo.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--with-gnu-ld

include ../../gar.mk

post-install:
	@# We need to use the system's 'su', because it must be suid.
	@$(if $(filter build,$(DESTIMG)),rm -f $(DESTDIR)$(bindir)/su)
	@# We need to use the system's 'chown', because this 'chown' does not work on Fedora Core 6.
	@# Since it should work, at some point we need to track down the problem.
	@$(if $(filter build,$(DESTIMG)),rm -f $(DESTDIR)$(bindir)/chown)
	@$(MAKECOOKIE)
