GARNAME = coreutils
GARVERSION = 7.1
CATEGORIES = utils
MASTER_SITES = ftp://ftp.gnu.org/gnu/$(GARNAME)/
DISTFILES = $(DISTNAME).tar.gz
PATCHFILES = $(DISTNAME)-perl.patch.gar $(DISTNAME)-sysinfo.patch $(DISTNAME)-disable_man.patch
LICENSE = GPL2

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile su

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--disable-rpath \
	--with-gnu-ld

include ../../gar.mk

pre-configure:
	@$(call FIX_LIBTOOL_LIBPATH,$(WORKSRC),configure)
	@$(MAKECOOKIE)

install-su:
	@install -m 755 -D $(WORKSRC)/src/su $(DESTDIR)$(bindir)/su
	@$(MAKECOOKIE)

post-install:
	@# We need to use the system's 'su', because it must be suid.
	@$(if $(filter build,$(DESTIMG)),rm -f $(DESTDIR)$(bindir)/su)
	@$(MAKECOOKIE)
