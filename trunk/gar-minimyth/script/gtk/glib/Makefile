GARNAME = glib
GARVERSION = 2.18.3
CATEGORIES = gtk
MASTER_SITES = http://ftp.gnome.org/pub/gnome/sources/glib/2.18/
DISTFILES = $(DISTNAME).tar.bz2
LICENSE = LGPL2

DESCRIPTION =
define BLURB
endef

DEPENDS    = lang/c
BUILDDEPS  =
ifneq ($(DESTIMG),build)
BUILDDEPS += gtk/glib
endif

CONFIGURE_SCRIPTS = $(WORKSRC)/configure
BUILD_SCRIPTS     = $(WORKSRC)/Makefile
INSTALL_SCRIPTS   = $(WORKSRC)/Makefile

CONFIGURE_ARGS = $(DIRPATHS) --build=$(GARBUILD) --host=$(GARHOST) \
	--cache-file=config.cache \
	--disable-static \
	--enable-shared \
	--with-gnu-ld

CONFIGURE_ENV  =
ifneq ($(DESTIMG),build)
CONFIGURE_ENV += \
	ac_cv_func_mmap_fixed_mapped='yes' \
	ac_cv_func_posix_getpwuid_r='yes' \
	ac_cv_func_posix_getgrgid_r='yes' \
	ac_cv_func_printf_unix98='yes' \
	ac_cv_func_snprintf_c99='yes' \
	ac_cv_func_vsnprintf_c99='yes' \
	glib_cv_stack_grows='no' \
	glib_cv_uscore='no' \
	glib_cv_va_val_copy='no'
endif

include ../../gar.mk

pre-configure:
	@$(call FIX_LIBTOOL,$(WORKSRC),configure)
	@$(MAKECOOKIE)

post-install:
	@rm -rf $(DESTDIR)$(libdir)/libgio-2.0.la
	@rm -rf $(DESTDIR)$(libdir)/libglib-2.0.la
	@rm -rf $(DESTDIR)$(libdir)/libgmodule-2.0.la
	@rm -rf $(DESTDIR)$(libdir)/libgobject-2.0.la
	@rm -rf $(DESTDIR)$(libdir)/libgthread-2.0.la
	@$(MAKECOOKIE)
