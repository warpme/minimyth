GARNAME = tcl
GARVERSION = 8.2.3
CATEGORIES = utils
MASTER_SITES = http://prdownloads.sourceforge.net/$(GARNAME)/
DISTFILES = $(GARNAME)$(GARVERSION).tar.gz
LICENSE = $(GARNAME)
$(GARNAME)_LICENSE_TEXT = $(WORKSRC)/license.terms

DESCRIPTION = 
define BLURB
endef

DEPENDS = lang/c

CONFIGURE_SCRIPTS = $(WORKSRC)/unix/configure
BUILD_SCRIPTS     = $(WORKSRC)/unix/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/unix/Makefile

WORKSRC = $(WORKDIR)/$(GARNAME)$(GARVERSION)

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--x-includes=$(DESTDIR)$(includedir) \
	--x-libraries=$(DESTDIR)$(libdir) \
	--enable-gcc \
	--enable-threads \
	$(if $(filter i386,$(GARCH_FAMILY)),--disable-64bit) \
	$(if $(filter x86_64,$(GARCH_FAMILY)),--enable-64bit) \
	--enable-load \
	$(if $(filter yes,$(mm_DEBUG)),--enable-symbols) \
	--enable-shared

include ../../gar.mk

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC)/unix/configure)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(bindir)/tclsh
	@ln -s tclsh$(word 1,$(subst ., ,$(GARVERSION))).$(word 2,$(subst ., ,$(GARVERSION))) $(DESTDIR)$(bindir)/tclsh
	@$(MAKECOOKIE)
