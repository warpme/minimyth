GARNAME = fontconfig
GARVERSION = 2.2.3
CATEGORIES = X11
MASTER_SITES = http://www.freedesktop.org/software/fontconfig/releases/
# This site is needed until freedesktop.org is up-to-date
# (freedesktop.org was hacked and has not been fully restored).
MASTER_SITES += ftp://ftp.fu-berlin.de/unix/linux/mirrors/gentoo/distfiles/
DISTFILES = $(GARNAME)-$(GARVERSION).tar.gz
LICENSE = fontconfig
fontconfig_LICENSE_TEXT = $(WORKSRC)/COPYING

DESCRIPTION = 
define BLURB
endef

DEPENDS   = lang/c lib/expat X11/freetype
ifneq ($(DESTIMG),build)
BUILDDEPS = X11/fontconfig
endif

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
  	--with-expat-includes=$(DESTDIR)$(includedir) \
  	--with-expat-lib=$(DESTDIR)$(libdir) \
	--with-freetype-config=$(DESTDIR)$(bindir)/freetype-config

include ../../gar.mk

# While fc-lang is never installed, it is build and run during build using the host compiler.
# Of course, this will not work when cross compiling. Therefore, we have this hack to install
# the version of fc-lang built when DESTIMG=build and then run this version of fc-lang when
# DESTIMG<>build. It is not pretty, but it works.
ifeq ($(DESTIMG),build)
INSTALL_BUILD_FC_LANG = cp $(WORKSRC)/fc-lang/fc-lang $(DESTDIR)$(bindir)
USE_BUILD_FC_LANG     =
else
INSTALL_BUILD_FC_LANG =
USE_BUILD_FC_LANG     = sed -i 's%\$$\$${dir}/fc-lang %fc-lang %g' $(WORKSRC)/fc-lang/Makefile
endif

post-patch:
	@# Libtool wants to hardcode library paths. This stops that unwanted behavior.
	@sed -i 's%^hardcode_libdir_flag_spec=.*%hardcode_libdir_flag_spec=%' $(WORKSRC)/configure
	@# Libtool wants to modify the library run path. This stops that unwanted behavior.
	@sed -i 's%^runpath_var=.*%runpath_var=%' $(WORKSRC)/configure
	@$(MAKECOOKIE)

post-configure:
	@$(USE_BUILD_FC_LANG)
	@$(MAKECOOKIE)

post-install:
	@rm -f $(DESTDIR)$(libdir)/libfontconfig.la
	@$(INSTALL_BUILD_FC_LANG)
	@sed -i 's%-L$${libdir}%-L$(DESTDIR)$${libdir}%g'         $(DESTDIR)$(libdir)/pkgconfig/fontconfig.pc
	@sed -i 's%-I$${includedir}%-I$(DESTDIR)$${includedir}%g' $(DESTDIR)$(libdir)/pkgconfig/fontconfig.pc
	@$(MAKECOOKIE)
